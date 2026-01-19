<p align="center" style="background-color:white">
 <a href="https://www.ravn.co/" rel="noopener">
 <img src="src/ravn_logo.png" alt="RAVN logo" width="150px"></a>
</p>
<p align="center">
 <a href="https://www.postgresql.org/" rel="noopener">
 <img src="https://www.postgresql.org/media/img/about/press/elephant.png" alt="Postgres logo" width="150px"></a>
</p>

---

<p align="center">A project to show off your skills on databases & SQL using a real database</p>

## 📝 Table of Contents

- [Case](#case)
- [Installation](#installation)
- [Data Recovery](#data_recovery)
- [Excersises](#excersises)

## 🤓 Case <a name = "case"></a>

As a developer and expert on SQL, you were contacted by a company that needs your help to manage their database which runs on PostgreSQL. The database provided contains four entities: Employee, Office, Countries and States. The company has different headquarters in various places around the world, in turn, each headquarters has a group of employees of which it is hierarchically organized and each employee may have a supervisor. You are also provided with the following Entity Relationship Diagram (ERD)

#### ERD - Diagram <br>

![Comparison](src/ERD.png) <br>

---

## 🛠️ Docker Installation <a name = "installation"></a>

1. Install [docker](https://docs.docker.com/engine/install/)

---

## 📚 Recover the data to your machine <a name = "data_recovery"></a>

Open your terminal and run the follows commands:

1. This will create a container for postgresql:

```
docker run --name nerdery-container -e POSTGRES_PASSWORD=password123 -p 5432:5432 -d --rm postgres:15.2
```

2. Now, we access the container:

```
docker exec -it -u postgres nerdery-container psql
```

3. Create the database:

```
create database nerdery_challenge;
```

5. Close the database connection:

```
\q
```

4. Restore de postgres backup file

```
cat /.../dump.sql | docker exec -i nerdery-container psql -U postgres -d nerdery_challenge
```

- Note: The `...` mean the location where the src folder is located on your computer
- Your data is now on your database to use for the challenge

---

## 📊 Excersises <a name = "excersises"></a>

Now it's your turn to write SQL queries to achieve the following results (You need to write the query in the section `Your query here` on each question):

1. Total money of all the accounts group by types.

```
SELECT type, SUM(mount)
FROM accounts
GROUP BY type;
```

2. How many users with at least 2 `CURRENT_ACCOUNT`.

```
SELECT COUNT(*) AS users_with_multiple_accounts
FROM (
    SELECT u.id
    FROM users u
    JOIN accounts a ON u.id = a.user_id
    GROUP BY u.id
    HAVING COUNT(*) >= 2
) sub;
```

3. List the top five accounts with more money.

```
SELECT account_id, mount
FROM accounts
ORDER BY mount DESC
LIMIT 5;

```

4. Get the three users with the most money after making movements.

```
WITH InitialBalances AS (
    SELECT user_id, SUM(mount) as initial_total
    FROM accounts
    GROUP BY user_id
),
Outflow AS (
    SELECT a.user_id, SUM(m.mount) as total_sent
    FROM movements m
    JOIN accounts a ON m.account_from = a.id
    WHERE m.type NOT IN ('IN')
    GROUP BY a.user_id
),
Inflow AS (
    SELECT a.user_id, SUM(m.mount) as total_received
    FROM movements m
    JOIN accounts a ON m.account_to = a.id
    GROUP BY a.user_id
),
Deposits AS (
    SELECT a.user_id, SUM(m.mount) as total_deposits
    FROM movements m
    JOIN accounts a ON m.account_from = a.id
    WHERE m.type IN ('IN')
    GROUP BY a.user_id
)
SELECT
    u.id,
    u.name,
    u.last_name,
    (
        COALESCE(ib.initial_total, 0) +
        COALESCE(inf.total_received, 0) -
        COALESCE(outf.total_sent, 0) +
        COALESCE(dep.total_deposits, 0)
    ) AS current_balance,
    ib.initial_total AS initial_balance,
    outf.total_sent AS total_outflow,
    inf.total_received AS total_inflow,
    dep.total_deposits AS total_deposits
FROM users u
LEFT JOIN InitialBalances ib ON u.id = ib.user_id
LEFT JOIN Outflow outf ON u.id = outf.user_id
LEFT JOIN Inflow inf ON u.id = inf.user_id
LEFT JOIN Deposits dep ON u.id = dep.user_id
ORDER BY current_balance DESC
LIMIT 3;

```

5.  In this part you need to create a transaction with the following steps:

    a. First, get the ammount for the account `3b79e403-c788-495a-a8ca-86ad7643afaf` and `fd244313-36e5-4a17-a27c-f8265bc46590` after all their movements.
    b. Add a new movement with the information:
    from: `3b79e403-c788-495a-a8ca-86ad7643afaf` make a transfer to `fd244313-36e5-4a17-a27c-f8265bc46590`
    mount: 50.75

    c. Add a new movement with the information:
    from: `3b79e403-c788-495a-a8ca-86ad7643afaf`
    type: OUT
    mount: 731823.56

        * Note: if the account does not have enough money you need to reject this insert and make a rollback for the entire transaction

    d. Put your answer here if the transaction fails(YES/NO):

    ```
        YES
    ```

    e. If the transaction fails, make the correction on step _c_ to avoid the failure:

    ```
        Your query
    ```

    f. Once the transaction is correct, make a commit

    ```
        Your query
    ```

    g. How much money the account `fd244313-36e5-4a17-a27c-f8265bc46590` have:

    ```
        Your query
    ```

6.  All the movements and the user information with the account `3b79e403-c788-495a-a8ca-86ad7643afaf`

```
Your query here
```

7. The name and email of the user with the highest money in all his/her accounts

```
Your query here
```

8. Show all the movements for the user `Kaden.Gusikowski@gmail.com` order by account type and created_at on the movements table

```
Your query here
```
