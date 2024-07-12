package cmd

import (
	"fmt"
	"todo-api/cmd/migrate"

	"github.com/spf13/cobra"
)

// migrateCmd represents the migrate command
var migrateCmd = &cobra.Command{
	Use:   "migrate",
	Short: "Run database migrations",
	Long:  "Run database migrations using golang-migrate tool.",
	Run: func(cmd *cobra.Command, args []string) {
		direction, _ := cmd.Flags().GetString("direction")
		switch direction {
		case "up":
			migrate.Up()
		case "down":
			migrate.Down()
		case "version":
			migrate.Version()
		default:
			fmt.Println("Invalid direction. Use 'up', 'down', or 'version'.")
		}
	},
}

func init() {
	rootCmd.AddCommand(migrateCmd)
	migrateCmd.Flags().StringP("direction", "d", "up", "Migration direction: up, down, or version")
}
