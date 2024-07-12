package migrate

import (
	"fmt"
	"log"
	"todo-api/internal/config"

	"github.com/gocql/gocql"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/cassandra"
	_ "github.com/golang-migrate/migrate/v4/source/file"
)

func newMigration() *migrate.Migrate {
	// Read the configuration
	//TODO: set env file
	config.ReadConfig("config.yml")
	cfg := config.Get()

	fmt.Printf("applying migrations on %s\n", cfg.DB.Host)

	// Initialize the ScyllaDB session
	cluster := gocql.NewCluster(cfg.DB.ContactPoints)
	cluster.Keyspace = cfg.DB.Keyspace
	cluster.Consistency = gocql.Quorum
	cluster.Authenticator = gocql.PasswordAuthenticator{
		Username: cfg.DB.User,
		Password: cfg.DB.Password,
	}

	session, err := cluster.CreateSession()
	if err != nil {
		log.Fatalf("failed to create ScyllaDB session: %v", err)
	}

	// Check if keyspace exists, create if it doesn't
	keyspaceExists := false
	query := session.Query("SELECT keyspace_name FROM system_schema.keyspaces WHERE keyspace_name = ?", cfg.DB.Keyspace).Consistency(gocql.One)
	iter := query.Iter()
	var existingKeyspace string
	for iter.Scan(&existingKeyspace) {
		if existingKeyspace == cfg.DB.Keyspace {
			keyspaceExists = true
			break
		}
	}
	if err := iter.Close(); err != nil {
		log.Fatalf("error checking keyspace existence: %v", err)
	}

	if !keyspaceExists {
		err := createKeyspace(session, cfg.DB.Keyspace)
		if err != nil {
			log.Fatalf("failed to create keyspace %s: %v", cfg.DB.Keyspace, err)
		}
	}

	// Wrap the session into a migrate-compatible driver
	driver, err := cassandra.WithInstance(session, &cassandra.Config{
		KeyspaceName: cfg.DB.Keyspace,
	})
	if err != nil {
		log.Fatalf("failed to create cassandra driver: %v", err)
	}

	// Migration source path
	source := cfg.DB.MigrationsPath
	fmt.Printf("using %s as migrations source\n", source)
	m, err := migrate.NewWithDatabaseInstance(source, "cassandra", driver)
	if err != nil {
		log.Fatalf("failed to create migrate instance: %v", err)
	}

	return m
}

func createKeyspace(session *gocql.Session, keyspaceName string) error {
	replicationStrategy := "{'class':'SimpleStrategy', 'replication_factor':1}"
	query := fmt.Sprintf("CREATE KEYSPACE IF NOT EXISTS %s WITH replication = %s", keyspaceName, replicationStrategy)
	err := session.Query(query).Exec()
	if err != nil {
		return err
	}
	fmt.Printf("Created keyspace %s\n", keyspaceName)
	return nil
}

func Version() {
	version, dirty, err := newMigration().Version()
	if err != nil {
		fmt.Printf("error obtaining version: %v\n", err)
		return
	}
	fmt.Printf("currently on DB migration version %d (dirty: %t)\n", version, dirty)
}

func Up() {
	err := newMigration().Up()
	if err == migrate.ErrNoChange {
		fmt.Printf("no changes detected\n")
		return
	}
	if err != nil {
		fmt.Printf("error migrating up: %v\n", err)
		return
	}
	println("migrated up successfully")
}

func Down() {
	err := newMigration().Down()
	if err != nil {
		fmt.Printf("error migrating down: %v\n", err)
		return
	}
	println("migrated down successfully")
}

func Steps(n int) {
	err := newMigration().Steps(n)
	if err != nil {
		fmt.Printf("error migrating by %d steps: %v\n", n, err)
		return
	}
	fmt.Printf("migrated by %d steps successfully\n", n)
}
