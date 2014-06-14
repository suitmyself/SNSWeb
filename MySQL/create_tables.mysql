/*DROP DATABASE t_sns;*/
CREATE DATABASE t_sns;
USE t_sns;

CREATE TABLE account (
    username varchar(64),
    password varchar(64) NOT NULL,
    salt char(128) NOT NULL,              /* To enhance security */
    email varchar(64) UNIQUE NOT NULL,     /* An email can only be bound to one username */

    PRIMARY KEY (username)
) DEFAULT CHARSET=utf8;

CREATE TABLE user_info (
    username varchar(64),
    realname varchar(64) DEFAULT NULL,
    sex tinyint(1) DEFAULT NULL,                 /* 0: female, 1: male, NULL: unknown */
    photo blob DEFAULT NULL,
    birthday date DEFAULT NULL,
    university varchar(64) DEFAULT NULL,
    school varchar(64) DEFAULT NULL,
    major varchar(64) DEFAULT NULL,
    entry_year year DEFAULT NULL,
    signature text DEFAULT NULL,
    sig_update_time datetime DEFAULT NULL,

    PRIMARY KEY (username),
    FOREIGN KEY (username) REFERENCES account (username) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE user_info_visibility (
    username varchar(64),
    attribute varchar(64),                  /* FIXME: how to convert column name to string in MySQL? */
    visible tinyint(1) DEFAULT NULL,            /* NULL: open to all, 0: open to friends, 1: private */

    PRIMARY KEY (username, attribute),
    FOREIGN KEY (username) REFERENCES account (username) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE friend_group (
    username varchar(64),
    group_name varchar(64),      /* Any user should have at least one friend group named "default" */

    PRIMARY KEY (username, group_name),
    FOREIGN KEY (username) REFERENCES account (username) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE interest_label (
    username varchar(64),
    interest varchar(64),

    PRIMARY KEY (username, interest),
    FOREIGN KEY (username) REFERENCES account (username) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE friend_pair (
    username1 varchar(64),
    group_name1 varchar(64),
    username2 varchar(64),
    group_name2 varchar(64),

    PRIMARY KEY (username1, username2),
--    FOREIGN KEY (username1) REFERENCES account (username),
--    FOREIGN KEY (username2) REFERENCES account (username),
--    FOREIGN KEY (group_name1) REFERENCES friend_group (group_name),   /* FIXME: Why failed? */
--    FOREIGN KEY (group_name2) REFERENCES friend_group (group_name),

    CHECK (
        username1 < username2    /* to avoid replication: friend(A, B) = friend(B, A) */
        AND EXISTS (SELECT * FROM friend_group AS fg
            WHERE fg.username = username1 AND fg.group_name = group_name2)
        AND EXISTS (SELECT * FROM friend_group AS fg
            WHERE fg.username = username2 AND fg.group_name = group_name1)
    )
) DEFAULT CHARSET=utf8;

CREATE TABLE add_friend_request (
    request_id int AUTO_INCREMENT,
    ts timestamp DEFAULT CURRENT_TIMESTAMP,
    from_username varchar(64),
    to_username varchar(64),
    group_name varchar(64),         /* Which of from_username's friend groups to place to_username. */
    message text,
    status tinyint(1),      /* NULL: unhandled, 0: accepted, 1: rejected */

    PRIMARY KEY (request_id),
--    FOREIGN KEY (from_username) REFERENCES account (username),
--    FOREIGN KEY (to_username) REFERENCES account (username) ON DELETE CASCADE, /* fixme */
--    FOREIGN KEY (group_name) REFERENCES friend_group (group_name),

    CHECK (
        EXISTS (SELECT * FROM friend_group AS fg
            WHERE fg.username = from_username AND fg.group_name = group_name)
        AND EXISTS (SELECT * FROM account AS ac WHERE ac.username = to_username)
    )
);

CREATE TABLE notice_friend_request (
    notice_id int AUTO_INCREMENT,
    ts timestamp DEFAULT CURRENT_TIMESTAMP,
    status tinyint(1),          /* 0: read, 1: unread */
    content text,
    request_id int,

    PRIMARY KEY (notice_id),
    FOREIGN KEY (request_id) REFERENCES add_friend_request (request_id) ON DELETE CASCADE
);

CREATE TABLE post (
    post_id int AUTO_INCREMENT,
    replyto_id int,
    username varchar(64),
    ts timestamp DEFAULT CURRENT_TIMESTAMP,
    content text,

    PRIMARY KEY (post_id),
--    FOREIGN KEY (username) REFERENCES account (username),
    FOREIGN KEY (replyto_id) REFERENCES post (post_id),

    CHECK (
        EXISTS (SELECT * FROM account AS ac WHERE ac.username = username)
    )
);
