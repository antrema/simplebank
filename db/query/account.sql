-- name: CreateAccount :one
INSERT INTO golang_014.accounts (
  owner,
  balance,
  currency
) VALUES (
  $1, $2, $3
) RETURNING *;


-- name: GetAccount :one
SELECT * FROM golang_014.accounts
WHERE id = $1 LIMIT 1;

-- name: GetAccountForUpdate :one
SELECT * FROM golang_014.accounts
WHERE id = $1 LIMIT 1
FOR NO KEY UPDATE;

-- name: ListAccounts :many
SELECT * FROM golang_014.accounts
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :one
UPDATE golang_014.accounts
SET balance = $2
WHERE id = $1
RETURNING *;

-- name: AddAccountBalance :one
UPDATE golang_014.accounts
SET balance = balance + sqlc.arg(amount)
WHERE id = sqlc.arg(id)
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM golang_014.accounts
WHERE id = $1;
