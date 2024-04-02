SELECT 
    item_option_name,
    SUM(total_price) AS total_sales
FROM
    (SELECT
        CONCAT(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(item_name, '일회용컵 사용::', ''),
                            '우유::', ''),
                        '(HOT&ICE::|컵 선택::).*?\\|\\|', ''),
                    '\\|\\|.*', ''),
                '\\|\\|', ' '),
            ' ',
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(option_name, '일회용컵 사용::', ''),
                        '우유::', ''),
                    '(HOT&ICE::|일회용컵 사용::).*?\\|\\|', ''),
                '\\|\\|.*', '')
        ) AS item_option_name,
        SUM(option_price) AS total_price
    FROM
        mstr_db.ods_mmc_ko_order_detail od
    WHERE
        order_id >= '20240301'
        AND order_id <= '20240315'
    GROUP BY
        item_name, option_name, option_price) AS subquery
GROUP BY
    item_option_name
ORDER BY
    total_sales DESC
LIMIT 10;
