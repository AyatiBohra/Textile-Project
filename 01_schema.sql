DROP TABLE IF EXISTS production;

CREATE TABLE production (
    ID                      TEXT,
    Month                   TEXT,
    Construction            TEXT,
    Req_Finish_Fabrics      REAL,
    Fabric_Allowance        REAL,
    rec_beam_length_yds     REAL,
    Shrink_allow            REAL,
    act_shrink_pct          REAL,
    Previous_pdn            REAL,
    Req_grey_fabric         REAL,
    req_beam_length_yds     REAL,
    total_pdn_per_machine   REAL,
    Rej_and_cut_Piece       REAL,
    Total_pdn_per_order     REAL,
    warp_count              TEXT,
    weft_count              INTEGER,
    epi                     INTEGER,
    ppi                     INTEGER
);

DROP TABLE IF EXISTS rejection;

CREATE TABLE rejection (
    order_id                INTEGER PRIMARY KEY,
    Construction            TEXT,
    Req_Finish_Fabrics      REAL,
    Fabric_Allowance        REAL,
    rec_beam_length_yds     REAL,
    Shrink_allow            REAL,
    Req_grey_fabric         REAL,
    req_beam_length_yds     REAL,
    total_pdn_yds           REAL,
    Rejection               REAL,
    warp_count              TEXT,
    weft_count              REAL,
    epi                     INTEGER,
    ppi                     INTEGER,
    rejection_rate_pct      REAL,
    yarn_type               TEXT
);
