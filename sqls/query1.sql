with t1(user_id, degree_fi, degree_en, degree_sv) as
(
  select 3601464, '3700', '1600', '2200' from dual union all
  select 1020   , '100' , '0'   , '0'    from dual union all
  select 3600520, '100,3200,400', '1300, 800, 3000', '1400, 600, 1500'  from dual union all
  select 3600882, '0',    '100',  '200'  from dual
)
, occurances(ocr) as
(select level as ocr from 
  (
    select 
    max(
        greatest(
            regexp_count(degree_fi,'[^,]+'),
            regexp_count(degree_en,'[^,]+'),
            regexp_count(degree_sv,'[^,]+')
            )
        ) mx
    from t1 )
    connect by level <= mx
 )
 select user_id , 
        regexp_substr(degree_fi,'[^,]+',1,o.ocr) degree_fi1,
        regexp_substr(degree_en,'[^,]+',1,o.ocr) degree_en1,
        regexp_substr(degree_sv,'[^,]+',1,o.ocr) degree_sv1
 from occurances o cross join t1
 where regexp_substr(degree_fi,'[^,]+',1,o.ocr)  IS NOT NULL
 and regexp_substr(degree_en,'[^,]+',1,o.ocr) is NOT NULL
 and regexp_substr(degree_sv,'[^,]+',1,o.ocr) is NOT NULL
 order by 1;

 
