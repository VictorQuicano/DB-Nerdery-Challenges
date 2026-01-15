-- Your answers here:
-- 1
SELECT type, SUM(mount) 
FROM accounts 
GROUP BY type;

-- 2
SELECT COUNT(*) AS users_with_multiple_accounts
FROM (
    SELECT u.id
    FROM users u
    JOIN accounts a ON u.id = a.user_id
    WHERE a.type = 'CURRENT_ACCOUNT'
    GROUP BY u.id
    HAVING COUNT(*) >= 2
) sub;

-- 3
SELECT account_id, mount
FROM accounts
ORDER BY mount DESC 
LIMIT 5;

-- 4

-- TO DO: How to consider movements? Add or subtract from accounts?

-- 5
    -- a) GET AMMOUNT OF MONEY IN THE '3b79e403-c788-495a-a8ca-86ad7643afaf' ACCOUNT
-- 6

-- 7

