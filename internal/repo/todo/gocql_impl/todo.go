package repository

import (
	"sort"
	"todo-api/internal/constants"
	"todo-api/internal/model"
	"todo-api/internal/repo/todo"

	"github.com/gocql/gocql"
)

type todoRepositoryImpl struct {
	session *gocql.Session
}

func NewTodoRepository(session *gocql.Session) todo.TodoRepository {
	return &todoRepositoryImpl{session: session}
}

func (r *todoRepositoryImpl) Save(todo model.Todo) error {
	query := `INSERT INTO todoapp.todos (id, user_id, title, description, status, created, updated) VALUES (?, ?, ?, ?, ?, ?, ?)`
	if err := r.session.Query(query, todo.ID, todo.UserID, todo.Title, todo.Description, todo.Status, todo.CreatedAt, todo.UpdatedAt).Consistency(gocql.One).Exec(); err != nil {
		return err
	}
	return nil
}

func (r *todoRepositoryImpl) FindByID(id string) (model.Todo, error) {
	query := `SELECT id, user_id, title, description, status, created, updated FROM todoapp.todos WHERE id = ?`
	var todo model.Todo

	if err := r.session.Query(query, id).Consistency(gocql.One).Scan(&todo.ID, &todo.UserID, &todo.Title, &todo.Description, &todo.Status, &todo.CreatedAt, &todo.UpdatedAt); err != nil {
		if err == gocql.ErrNotFound {
			return model.Todo{}, nil
		}
		return model.Todo{}, err
	}

	return todo, nil
}

func (r *todoRepositoryImpl) DeleteByID(id string) error {
	query := `DELETE FROM todoapp.todos WHERE id = ?`
	if err := r.session.Query(query, id).Consistency(gocql.One).Exec(); err != nil {
		return err
	}
	return nil
}

func (r *todoRepositoryImpl) ExistsByID(id string) (bool, error) {
	var todoID string
	query := `SELECT id FROM todoapp.todos WHERE id = ? LIMIT 1`
	if err := r.session.Query(query, id).Consistency(gocql.One).Scan(&todoID); err != nil {
		if err == gocql.ErrNotFound {
			return false, nil
		}
		return false, err
	}
	return true, nil
}

func (r *todoRepositoryImpl) ListTodos(lastID string, limit int, status string, sortOrder string) ([]model.Todo, string, error) {
	var todos []model.Todo
	var nextLastID string

	var query string
	if lastID == "" {
		query = `SELECT id, user_id, title, description, status, created, updated FROM todoapp.todos WHERE status = ? LIMIT ? ALLOW FILTERING`
	} else {
		query = `SELECT id, user_id, title, description, status, created, updated FROM todoapp.todos WHERE id > ? AND status = ? LIMIT ? ALLOW FILTERING`
	}

	q := r.session.Query(query).Consistency(gocql.One)

	if lastID == "" {
		q.Bind(status, limit)
	} else {
		q.Bind(lastID, status, limit)
	}

	iter := q.Iter()
	defer iter.Close()
	var todo model.Todo

	for iter.Scan(&todo.ID, &todo.UserID, &todo.Title, &todo.Description, &todo.Status, &todo.CreatedAt, &todo.UpdatedAt) {
		todos = append(todos, todo)
		nextLastID = todo.ID
	}

	if err := iter.Close(); err != nil {
		return nil, "", err
	}

	sort.Slice(todos, func(i, j int) bool {
		if sortOrder == constants.DescS || sortOrder == constants.DescC {
			return todos[i].CreatedAt.After(todos[j].CreatedAt) // Descending order
		}
		return todos[i].CreatedAt.Before(todos[j].CreatedAt) // Ascending order
	})

	return todos, nextLastID, nil
}
