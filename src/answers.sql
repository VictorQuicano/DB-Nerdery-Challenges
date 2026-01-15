-- Your answers here:
-- 1
SELECT c.name, count(*) FROM countries c INNER JOIN states s ON c.id = s.country_id GROUP BY c.name ;

-- 2
SELECT COUNT(*) employees_without_bosses FROM employees WHERE supervisor_id IS NULL;

-- 3
SELECT c.name name, n.address, n.count 
    FROM countries c 
    INNER JOIN (
        SELECT o.country_id, o.address, count(*) count 
        FROM offices o 
        INNER JOIN employees e 
        ON  o.id = e.office_id 
        GROUP BY o.id
    ) n 
    ON c.id = n.country_id 
    ORDER BY 
    count DESC
    LIMIT 5 ;

-- 4
SELECT e.id supervisor_id, COUNT(*) 
FROM employees e 
INNER JOIN employees m 
ON e.id = m.supervisor_id 
GROUP BY e.id 
ORDER BY count DESC 
LIMIT 3;

-- 5
SELECT count(*) list_of_office 
FROM offices 
WHERE state_id = (
    SELECT id FROM states 
    WHERE name ILIKE 'COLORADO' 
    LIMIT 1
);

-- 6
SELECT o.name name, COUNT(*) 
FROM offices o 
INNER JOIN employees e ON o.id = e.office_id 
GROUP BY o.id 
ORDER BY count DESC

-- 7
(SELECT o.address address, COUNT(*) 
FROM offices o 
INNER JOIN employees e ON o.id = e.office_id 
GROUP BY o.id 
ORDER BY count DESC
LIMIT 1)
UNION ALL
(
SELECT o.address address, COUNT(*) 
FROM offices o 
INNER JOIN employees e ON o.id = e.office_id 
GROUP BY o.id 
ORDER BY count
LIMIT 1
);

-- 8
SELECT e.uuid, e.full_name, e.email, e.job_title, o.company, o.country, o.state, e.boss_name 
FROM (
    SELECT e.uuid, e.first_name || ' ' || e.last_name full_name, e.email, e.job_title, s.first_name boss_name, e.office_id 
    FROM employees e 
    INNER JOIN employees s 
    ON e.supervisor_id = s.id
) e
LEFT JOIN (
    SELECT o.id, o.name company, s.country country, s.state state 
    FROM offices o 
    INNER JOIN (
        SELECT s.id state_id, s.name state, c.name country 
        FROM states s 
        INNER JOIN countries c 
        ON s.country_id = c.id
    ) s 
    ON o.state_id = s.state_id) o
ON e.office_id = o.id;