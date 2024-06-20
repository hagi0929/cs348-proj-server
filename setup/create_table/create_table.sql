-- DROP TABLE ServiceUser;
-- DROP TABLE Problem;
-- DROP TABLE TestCase;

CREATE TABLE ServiceUser (
    user_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);



CREATE TABLE Problem (
    problem_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    created_by INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    FOREIGN KEY (created_by) REFERENCES ServiceUser(user_id) ON DELETE SET NULL
);

CREATE TABLE TestCase (
    testcase_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    problem_id INT NOT NULL,
    is_public BOOLEAN NOT NULL DEFAULT FALSE,
    input TEXT NOT NULL,
    output TEXT NOT NULL,
    FOREIGN KEY (problem_id) REFERENCES Problem(problem_id) ON DELETE CASCADE
);

CREATE TABLE Role (
    role_id INT GENERATED ALWAYS AS IDENTITY,
    role_name TEXT,

    PRIMARY KEY(role_id)
);

CREATE TABLE UserRole (
    user_id INT,
    role_id INT,

    FOREIGN KEY(user_id) REFERENCES ServiceUser(user_id) ON DELETE CASCADE,
    FOREIGN KEY(role_id) REFERENCES Role(role_id) ON DELETE SET NULL,
    PRIMARY KEY(user_id, role_id)
);

CREATE TABLE ContestParticipant (
    contest_id INT,
    score INT,
    user_id INT,
    
    FOREIGN KEY(contest_id) REFERENCES Contest(contest_id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES ServiceUser(user_id) ON DELETE CASCADE,
    PRIMARY KEY(contest_id, user_id)
);

CREATE TABLE Permission (
    permission_id INT GENERATED ALWAYS AS IDENTITY,
    permission_name TEXT,

    PRIMARY_KEY(permission_id)
);

CREATE TABLE Tag(
    tag_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    type TEXT NOT NULL,
    content TEXT NOT NULL
)

CREATE TABLE ProblemTag (
    problem_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (problem_id, tag_id),
    FOREIGN KEY (problem_id) REFERENCES Problem(problem_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Tag(tag_id) ON DELETE CASCADE
);

CREATE TABLE Discussion (
    discussion_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    parentdiscussion_id INT DEFAULT NULL,
    problem_id INT NOT NULL,
    user_id INT NOT NULL,
    content VARCHAR(500) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    FOREIGN KEY (parentdiscussion_id) REFERENCES Discussion(discussion_id),
    FOREIGN KEY (problem_id) REFERENCES Problem(problem_id),
    FOREIGN KEY (user_id) REFERENCES ServiceUser(user_id)
);
