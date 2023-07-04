from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

default_args = {
    'owner': 'kalm',
    'start_date': datetime(2023, 7, 3),
    'schedule_inteval':'15 8 * * *'
}

dag = DAG('grouped_dag', default_args=default_args, schedule_interval=None)

start_task = DummyOperator(task_id='start_task', dag=dag)

def task1():
    print("Executing Task 1")

task1_task = PythonOperator(
    task_id='task1',
    python_callable=task1,
    dag=dag
)

def task2():
    print("Executing Task 2")

task2_task = PythonOperator(
    task_id='task2',
    python_callable=task2,
    dag=dag
)

end_task = DummyOperator(task_id='end_task', dag=dag)

start_task >> task1_task >> task2_task >> end_task

