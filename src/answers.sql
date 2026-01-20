-- Your answers here:
-- 1
SELECT 
    c.name, 
    count(*) 
FROM countries c 
INNER JOIN states s 
ON c.id = s.country_id 
GROUP BY c.name ;

-- 2
SELECT 
    COUNT(*) employees_without_bosses 
FROM employees 
WHERE supervisor_id IS NULL;

-- 3
SELECT
    c.name AS country_name,
    o.address,
    COUNT(e.id) AS employee_count
FROM countries c
JOIN offices o
    ON c.id = o.country_id
JOIN employees e
    ON o.id = e.office_id
GROUP BY c.id, c.name, o.id, o.address
ORDER BY employee_count DESC
LIMIT 5;


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
SELECT 
    e.uuid,
    e.first_name || ' ' || e.last_name AS full_name,
    e.email,
    e.job_title,
    o.name AS company,
    c.name AS country,
    s.name AS state,
    b.first_name AS boss_name
FROM employees e
INNER JOIN employees b
    ON e.supervisor_id = b.id
LEFT JOIN offices o
    ON e.office_id = o.id
LEFT JOIN states s
    ON o.state_id = s.id
LEFT JOIN countries c
    ON s.country_id = c.id;
