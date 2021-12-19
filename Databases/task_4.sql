1. Получить номера и имена поставщиков, не поставляющие никакие товары, и названия городов, в которых они дислоцированы
select
	s.sname,
    s.scity,
    sgb.sid
from s
left join sgb
	on s.sid = sgb.sid
where sgb.sid is null


2. Получить названия и коды и коды всех товаров, поставляемых теми поставщиками, которые поставляют какие-либо товары на базу с номером B1
select
	sgb.gid,
    g.gname
from sgb
inner join g 
	on sgb.gid = g.gid
where sid in (select distinct sid from sgb where bid = 'B1')
order by 1

3. Получить номера и названия баз и количество разных видов товаров, поставляемых на эти базы (учесть и базы, нат которые товары не поставляются)
select
b.bid,
count(distinct sgb.gid) as cnt
from b
left join sgb 
	on b.bid = sgb.bid
group by 1
order by 1
4. Найти поставщиков, получивших минимальный доход от поставок товаров 
(доход от поставки товара определояется как произведение суммарного количествова поставленного товара на его цену)
WITH t1 AS (
select
	s.sid,
    s.sname,
    (g.price*sgb.qty) as price
from s
left join sgb 
	on s.sid = sgb.sid
left join g 
	on sgb.gid = g.gid
where g.price is not null)

select
	t1.sname
from t1
where price = (select min(price) from t1)

5. Получить номера и названия баз, для которых среднее количество поставляемых в одной поставке товаров с кодом G1 больше 
чем минимальное количество любых товаров, поставляемых на торговую базу с номером B1

select
	t1.bid,
    t1.avg_qty

from (
    select
        b.bid,
        avg(sgb.qty)::integer as avg_qty
    from b
    left join sgb 
        on b.bid = sgb.bid
    where sgb.gid = '2'
    group by 1) t1
where 
	avg_qty > (	select
                    min(sgb.qty) as min_qty
                from b
                left join sgb 
                    on b.bid = sgb.bid
                where b.bid = '1')
-------------------------------------------------------------------------------------------------
1. Получить пары Номер поставщика - код товара, такие, что данный поставщик не поставляет данный товар
SELECT 
	t1.SName,
    t3.GName
FROM S t1, 
	 SGB t2 
inner join G t3 
	on t2.Gid = t3.Gid
where (t1.Sid,t3.Gid) NOT IN (SELECT t4.Sid,t4.Gid FROM SGB t4)
order by 1,2
    
2. Получить коды и названия товаров, поставляемых только на базу с номером B2

SELECT
	t1.Gid,
    t2.GName
FROM SGB t1
INNER JOIN G t2 
	on t1.Gid = t2.Gid
INNER JOIN B t3 
	on t1.Bid = t3.Bid 
	and t3.Bid = 'B2'

3. Получить названия торговых баз, в которые осуществляют поставки максимальное количество поставщиков

WITH tab1 AS (
	SELECT
        t1.BName,
        count(t2.Sid) as cnt
    FROM B t1
    left join SGB t2 
        on t1.Bid = t2.Bid
    group by t1.BName
    order by 2 desc
)
  
SELECT
	BName,
    cnt
FROM tab1
WHERE cnt = (select max(cnt) FROM tab1)

4. Получить имена поставщиков и количество разных видов товаров, поставляемых этими поставщиками
(учесть и поставщиков, которые не поставляют товары)

	SELECT
        t1.BName,
        count(distinct t2.Sid)
    FROM B t1
    left join SGB t2 
        on t1.Bid = t2.Bid
    group by 1
	
5. Получить название товара и суммарный доход от его поставок для всех товаров, цена которых превышает цену
любого товара, поставляемого поставщиком с номером S1

select
	t1.Gid,
    t1.GName,
    case
    	when sum(t1.Price*t2.Qty) is null then 0 else sum(t1.Price*t2.Qty)
    end as sum_price
from G t1
left join SGB t2 
	on t1.Gid = t2.Gid
WHERE t1.Price > 	(select 
						min(t3.Price)
					from S t1
					left join SGB t2 
						on t1.Sid = t2.Sid
					left join G t3 on t2.Gid = t3.Gid
					where t1.Sid = 'S1')
group by 1
order by 1
-------------------------------------------------------------------------------------------------
1. Получить номера и имена поставщиков, которые поставляют товары хотя бы на одну базу из тех, на которые поставляется товар с номером G3.

2. Получить коды и названия товаров, не поставляемых ни одним поставщиком, и названия городов, в которых они производятся.

3. Для каждого поставщика получить его номер, имя и общее количество поставленных им товаров (учесть и поставщиков, которые не поставляли товары)


4. Получить названия городов, в которых расположено максимальное количество торговых баз.

5. Получить номера и названия баз и общую стоимость поставленных на эти базы товаров для тех баз, на которых количество поставляемых в поставке товаров больше среднего количества товаров, поставляемых в одной поставке поставщиком с номером S1

-------------------------------------------------------------------------------------------------
1. Получить названия и коды товаров, которые поставляются на те же базы, на которые поставляет товары поставщик с номером S1
select
	sgb.gid,
	g.gname
from sgb
inner join g 
	on g.gid = sgb.gid
where bid in (select bid from sgb where sid = 'S1')

2. Получить все пары "Номер поставщика - номер базы" такие, что данный поставщик не поставляет никакие товары на данную базу
select
	b.bid,
    s.sid
from b,s
where (b.bid, s.sid) not in (select distinct bid, sid from sgb)

3. Получить коды и названия товаров, поставляемых более чем на одну базу
select
    sgb.gid,
    g.gname
from sgb
inner join g 
	on g.gid = sgb.gid
group by 1,2
having count(distinct sgb.bid) > 1

4. Получить коды и названия товаров, поставки которых принесли максимальный доход

WITH t1 as(
select
	g.gid,
    g.gname,
    (g.price*sgb.qty) as price
from g
left join sgb 
	on g.gid = sgb.gid
)

select
*
from t1 
where price = (select max(price) from t1)

5. Получить название торговой базы, название товара, суммарное количество поставок этого товара для тех баз, 
у которых среднее количество поставляемых в одной поставке товаров с номером G1 больше 300

with t1 as (
select
	b.bid,
    b.bname,
    avg(sgb.qty)::integer as avg_qty
from b
inner join sgb 
	on b.bid = sgb.bid 
    and sgb.gid = 'G1'
group by 1,2
)

select 
    t1.bname,
    g.gname,
    count(g.gname) as cnt
from t1
left join sgb
	on t1.bid = sgb.bid
inner join g 
	on g.gid = sgb.gid
where avg_qty > 300
group by 1,2
