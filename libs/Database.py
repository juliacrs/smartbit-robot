import psycopg2

import os       # pega a var de amb do SO
from dotenv import load_dotenv

load_dotenv()

# Passar como string >>  tirar ',' e trocar: database > dbname
db_conn =f"""
        host='{os.getenv('DB_HOST')}'
        dbname='{os.getenv('DB_NAME')}'
        user='{os.getenv('DB_USER')}'
        password='{os.getenv('DB_PASS')}'
    """
# db_conn ="""
#         host='localhost'
#         dbname='smartbit'
#         user='postgres'
#         password='QAx@123'
#     """

def execute(query):
    conn = psycopg2.connect(db_conn)

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()

def insert_membership(data):

    account = data["account"]
    plan = data["plan"]
    credit_card = data["credit_card"]["number"][-4]

    query = f"""
        BEGIN; -- Inicia uma transação

        -- Remove o registro pelo email
        DELETE FROM accounts
        WHERE email = '{account["email"]}';

        -- Insere uma nova conta e obtém o ID da conta recém-inserida
        WITH new_account AS (
            INSERT INTO accounts (name, email, cpf)
            VALUES ('{account["name"]}', '{account["email"]}', '{account["cpf"]}')
            RETURNING id
        )

        -- Insere um registro na tabela memberships com o ID da conta
        INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
        SELECT id, {plan["id"]}, '{credit_card}', {plan["price"]}, true
        FROM new_account;

        COMMIT; -- Confirma a transação
    """
    execute(query)

def insert_account(account):
    query = f"""
    INSERT INTO accounts (name, email, cpf) 
    VALUES ('{account['name']}', '{account['email']}', '{account['cpf']}');
    """   # aula 44
    execute(query)

    # conn = psycopg2.connect(
    #     host='localhost',
    #     database='smartbit',
    #     user='postgres',
    #     password='QAx@123'
    #     )

    # cur = conn.cursor()
    # cur.execute(query)
    # conn.commit()
    # conn.close()


def delete_account_by_email(email):
    query = f"DELETE FROM accounts WHERE email= '{email}';"   # aula 36
    execute(query)
