CREATE TABLE system_message (
    notice_id int AUTO_INCREMENT,
    ts timestamp DEFAULT CURRENT_TIMESTAMP,
    status tinyint(1),          /* 0: read, 1: unread */
    content text,
    to_username varchar(64),

    PRIMARY KEY (notice_id),
    FOREIGN KEY (to_username) REFERENCES account (username) ON DELETE CASCADE
)