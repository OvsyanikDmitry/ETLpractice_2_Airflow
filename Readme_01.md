Краткое описание действий на 2-ух этапах.
Этап 1.
В условии задачи, в таблице слоя staging.user_orders_log и слоя mart.f_sales появляются поля status, при этом первый инкремент приходит со старыми данными без статуса. 
Необходимо провести миграцию первых данных так, чтобы статус учитывался shipped. В файле alter.sql прописаны DDL добавления колонок со статусом и выставления статуса для новых данных по умолчанию. 
В файле s3.py скрипт дага, который уже соответствует условию второго этапа. 
Для корректных расчетов был изменен скрипт миграции в файле mart.f_sales. 

Этап 2. 
Схема витрины данных. 
mart.f_customer_retention
1. new_customers_count — кол-во новых клиентов (тех, которые сделали только один 
заказ за рассматриваемый промежуток времени).
2. returning_customers_count — кол-во вернувшихся клиентов (тех,
которые сделали только несколько заказов за рассматриваемый промежуток времени).
3. refunded_customer_count — кол-во клиентов, оформивших возврат за 
рассматриваемый промежуток времени.
4. period_name — weekly.
5. period_id — идентификатор периода (номер недели или номер месяца).
6. item_id — идентификатор категории товара.
7. new_customers_revenue — доход с новых клиентов.
8. returning_customers_revenue — доход с вернувшихся клиентов.
9. customers_refunded — количество возвратов клиентов.

в файле mart.f_customer_retention.sql 
скрипт создания витрины с метриками согласно схеме витрины данных. 
Витрина создана в виде View, такой вид позволяет чаще обновлять данные в витрине. 

UPD. файл s3_02.py содержит усовершенствованный DAG с логированием
