-- name: CreateEntry :one
INSERT INTO golang_014.entries (
  account_id,
  amount
) VALUES (
  $1, $2
) RETURNING *;

-- name: GetEntry :one
SELECT * FROM golang_014.entries
WHERE id = $1 LIMIT 1;

-- name: ListEntries :many
SELECT * FROM golang_014.entries
WHERE account_id = $1
ORDER BY id
LIMIT $2
OFFSET $3;
