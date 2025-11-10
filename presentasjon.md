# dbt

* ### data build tool - bygger datamodeller / datavarehus
* ### bygger en avhengighetsgraf (DAG) - muliggjør helhetlige kjøringer av hele modellen
* ### håndterer testing, dokumentasjon og miljøer på en standardisert måte   

<br>

# metodikk

* ### dbt har en egen (sterkt) anbefalt struktur, stil og oppsett https://docs.getdbt.com/best-practices
* ### medaljongarkitektur (bronse / sølv / gull / semantisk)
* ### eksplisitt referanse til modeller

```
select * from {{ ref('stg_customers') }}
```

<br>

# tester

* ### fungerer som kvalitetssikring inne i modellen, byggingen feiler (eller advarer)
* ### typisk unique / not null / relationship / accepted_values

* ### custom - kan bygges i python eller sql

# seeds

* ### enkel import av csv

# 



