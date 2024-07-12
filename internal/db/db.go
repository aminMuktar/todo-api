package db

import (
	"fmt"
	"todo-api/internal/config"

	"github.com/gocql/gocql"
)

type Connection struct {
	Session  *gocql.Session
	Keyspace string
}

func New(cfg config.Config) (*Connection, error) {
	cluster := gocql.NewCluster(cfg.DB.ContactPoints)
	cluster.Keyspace = cfg.DB.Keyspace
	cluster.Consistency = gocql.Quorum
	cluster.Authenticator = gocql.PasswordAuthenticator{
		Username: cfg.DB.User,
		Password: cfg.DB.Password,
	}

	session, err := cluster.CreateSession()
	if err != nil {
		return nil, fmt.Errorf("failed to create ScyllaDB session: %w", err)
	}

	return &Connection{
		Session:  session,
		Keyspace: cfg.DB.Keyspace,
	}, nil
}

func (c *Connection) Close() {
	c.Session.Close()
}

func (c *Connection) Name() string {
	return c.Keyspace
}
