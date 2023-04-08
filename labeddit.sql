-- Active: 1678998954344@@127.0.0.1@3306

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL
);

INSERT INTO users (id, name, email, password, role)
VALUES
	("u001", "Maria", "maria@email.com", "$2y$12$1N5zm9D1yJlp3/ZcqBIWJOskqX2gHz0Dkk2mHqd0IQ3rKdWOpWMoi", "NORMAL"),
	("u002", "Veronica", "veronica@email.com", "$2y$12$wJU4l2i93xuAOctpgP.zkOsx5h4eml7PwCq81tdtxBQsAo6tLMcR2", "NORMAL"),
	("u003", "Matheus", "matheus@email.com", "$2y$12$//5rjmqEYNmBa6TdcU6InOsQtcF9ZiwPQ7K.zlpMSZStoeZHGtfxu", "ADMIN");

CREATE TABLE posts (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    creator_id TEXT NOT NULL,
    content TEXT UNIQUE NOT NULL,
    likes INTEGER DEFAULT (0) NOT NULL,
    dislikes INTEGER DEFAULT (0) NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL,
    updated_at TEXT DEFAULT (DATETIME()) NOT NULL,
    FOREIGN KEY (creator_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO posts (id, creator_id, content, likes)
VALUES
	("p001", "u001", "Bora pra praia!", 2),
	("p002", "u002", "Saudades de vocês :(", 1),
	("p003", "u003", "Vamos no bar hoje?", 1);


CREATE TABLE likes_dislikes (
    user_id TEXT NOT NULL,
    post_id TEXT NOT NULL,
    like INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO likes_dislikes (user_id, post_id, like)
VALUES
    ("u001", "p002", 1),
    ("u002", "p001", 1),
    ("u001", "p003", 1),
    ("u003", "p001", 1);


CREATE TABLE comments (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    creator_id TEXT NOT NULL,
    content TEXT UNIQUE NOT NULL,
    likes INTEGER DEFAULT (0) NOT NULL,
    dislikes INTEGER DEFAULT (0) NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL,
    post_id TEXT NOT NULL,
    FOREIGN KEY (creator_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO comments (id, creator_id, content, likes, post_id)
VALUES
	("c001", "u001", "Vamos!", 2, "p003"),
	("c002", "u002", "Não quero", 1, "p003"),
	("c003", "u003", "Talvez", 1, "p003"),
    ("c004", "u003", "Não gostei!", 0, "p002"),
	("c005", "u001", "Parabéns", 0, "p001"),
	("c006", "u002", "O Jaskier é lindo", 0, "p002");

CREATE TABLE likes_dislikes_comments (
    user_id TEXT NOT NULL,
    comment_id TEXT NOT NULL,
    like INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comments (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO likes_dislikes_comments (user_id, comment_id, like)
VALUES
    ("u001", "c002", 1),
    ("u002", "c001", 1),
    ("u001", "c003", 1),
    ("u003", "c001", 1);


-- SELECT
--     posts.id,
--     posts.creator_id,
--     posts.content,
--     posts.likes,
--     posts.dislikes,
--     posts.created_at,
--     posts.updated_at,
--     users.name AS creator_name
-- FROM posts
-- JOIN users
-- ON posts.creator_id = users.id;

-- SELECT
--     comments.id,
--     comments.creator_id,
--     comments.content,
--     comments.likes,
--     comments.dislikes,
--     comments.created_at,
--     comments.updated_at,
--     users.name AS creator_name
-- FROM comments
-- JOIN users
-- ON comments.creator_id = users.id
-- JOIN posts
-- ON comments.post_id = posts.id
-- WHERE
--    post_id = "p002";
