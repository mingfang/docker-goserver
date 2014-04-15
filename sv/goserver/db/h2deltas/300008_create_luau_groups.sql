CREATE TABLE luau_groups (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
    name VARCHAR,
    fullName VARCHAR,
    uri VARCHAR
);

CREATE TABLE luau_groups_users (
    luau_group_id BIGINT,
    user_id BIGINT
);

ALTER TABLE luau_groups_users ADD CONSTRAINT fk_luau_group_id FOREIGN KEY(luau_group_id) REFERENCES luau_groups(id);
ALTER TABLE luau_groups_users ADD CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES users(id);
ALTER TABLE luau_groups ADD CONSTRAINT unique_uri UNIQUE (uri);

--//@UNDO

DROP TABLE luau_groups_users;

DROP TABLE luau_groups;