select 
    t2.seller_city
    ,t2.seller_state
    ,t1.* 
FROM
    (SELECT T2.seller_id
        ,AVG(t5.review_score) as avg_review_score
        ,t3.idade_base as idade_base_dias
        ,1+ CAST((t3.idade_base / 30) as INTEGER) as idade_base_mes   
        ,CAST(julianday('2017-04-01')-julianday(MAX(t1.order_approved_at)) as INTEGER) as qtde_dias_ult_venda
        ,COUNT(DISTINCT strftime('%m', t1.order_approved_at)) as qtde_mes_ativacao
        ,CAST(COUNT(DISTINCT strftime('%m', t1.order_approved_at)) as float)/MIN(1+ CAST((t3.idade_base / 30) as INTEGER), 6) as prop_ativacao
        ,SUM(case when julianday(t1.order_estimated_delivery_date)<julianday(t1.order_delivered_customer_date) then 1 else 0 end )/COUNT(DISTINCT t2.order_id) as prop_atraso
        ,CAST(AVG(julianday(t1.order_estimated_delivery_date) - julianday(t1.order_purchase_timestamp)) as integer) as avg_tempo_entrega_estimado
        ,SUM(T2.price) as receita_total
        ,SUM(T2.price) / COUNT(DISTINCT T2.order_id) as avg_vl_venda
        ,SUM(T2.price) /MIN(1+ CAST((t3.idade_base / 30) as INTEGER), 6) as avg_vl_venda_mes
        ,SUM(T2.price)/COUNT(DISTINCT strftime('%m', t1.order_approved_at)) as avg_vl_venda_mes_ativado
        ,COUNT(distinct T2.order_id) as qtde_vendas
        ,COUNT(T2.product_id) AS qtde_produto
        ,COUNT(DISTINCT T2.product_id) as qtde_produto_dst
        ,SUM(T2.price)/COUNT(T2.product_id) avg_vl_produto
        ,COUNT(T2.product_id)/COUNT(distinct T2.order_id) as avg_qtde_produto_venda
        ,SUM(case when t4.product_category_name = 'cama_mesa_banho' then 1 else 0 end) as cama_mesa_banho
        ,SUM(case when t4.product_category_name = 'beleza_saude' then 1 else 0 end) as beleza_saude
        ,SUM(case when t4.product_category_name = 'esporte_lazer' then 1 else 0 end) as esporte_lazer
        ,SUM(case when t4.product_category_name = 'moveis_decoracao' then 1 else 0 end) as moveis_decoracao
        ,SUM(case when t4.product_category_name = 'informatica_acessorios' then 1 else 0 end) as informatica_acessorios
        ,SUM(case when t4.product_category_name = 'utilidades_domesticas' then 1 else 0 end) as utilidades_domesticas
        ,SUM(case when t4.product_category_name = 'relogios_presentes' then 1 else 0 end) as relogios_presentes
        ,SUM(case when t4.product_category_name = 'telefonia' then 1 else 0 end) as telefonia
        ,SUM(case when t4.product_category_name = 'ferramentas_jardim' then 1 else 0 end) as ferramentas_jardim
        ,SUM(case when t4.product_category_name = 'automotivo' then 1 else 0 end) as automotivo
        ,SUM(case when t4.product_category_name = 'brinquedos' then 1 else 0 end) as brinquedos
        ,SUM(case when t4.product_category_name = 'cool_stuff' then 1 else 0 end) as cool_stuff
        ,SUM(case when t4.product_category_name = 'perfumaria' then 1 else 0 end) as perfumaria
        ,SUM(case when t4.product_category_name = 'bebes' then 1 else 0 end) as bebes
        ,SUM(case when t4.product_category_name = 'eletronicos' then 1 else 0 end) as eletronicos
        ,SUM(case when t4.product_category_name = 'papelaria' then 1 else 0 end) as papelaria
        ,SUM(case when t4.product_category_name = 'fashion_bolsas_e_acessorios' then 1 else 0 end) as fashion_bolsas_e_acessorios
        ,SUM(case when t4.product_category_name = 'pet_shop' then 1 else 0 end) as pet_shop
        ,SUM(case when t4.product_category_name = 'moveis_escritorio' then 1 else 0 end) as moveis_escritorio
        ,SUM(case when t4.product_category_name = 'consoles_games' then 1 else 0 end) as consoles_games
        ,SUM(case when t4.product_category_name = 'malas_acessorios' then 1 else 0 end) as malas_acessorios
        ,SUM(case when t4.product_category_name = 'construcao_ferramentas_construcao' then 1 else 0 end) as construcao_ferramentas_construcao
        ,SUM(case when t4.product_category_name = 'eletrodomesticos' then 1 else 0 end) as eletrodomesticos
        ,SUM(case when t4.product_category_name = 'instrumentos_musicais' then 1 else 0 end) as instrumentos_musicais
        ,SUM(case when t4.product_category_name = 'eletroportateis' then 1 else 0 end) as eletroportateis
        ,SUM(case when t4.product_category_name = 'casa_construcao' then 1 else 0 end) as casa_construcao
        ,SUM(case when t4.product_category_name = 'livros_interesse_geral' then 1 else 0 end) as livros_interesse_geral
        ,SUM(case when t4.product_category_name = 'alimentos' then 1 else 0 end) as alimentos
        ,SUM(case when t4.product_category_name = 'moveis_sala' then 1 else 0 end) as moveis_sala
        ,SUM(case when t4.product_category_name = 'casa_conforto' then 1 else 0 end) as casa_conforto
        ,SUM(case when t4.product_category_name = 'bebidas' then 1 else 0 end) as bebidas
        ,SUM(case when t4.product_category_name = 'audio' then 1 else 0 end) as audio
        ,SUM(case when t4.product_category_name = 'market_place' then 1 else 0 end) as market_place
        ,SUM(case when t4.product_category_name = 'construcao_ferramentas_iluminacao' then 1 else 0 end) as construcao_ferramentas_iluminacao
        ,SUM(case when t4.product_category_name = 'climatizacao' then 1 else 0 end) as climatizacao
        ,SUM(case when t4.product_category_name = 'moveis_cozinha_area_de_servico_jantar_e_jardim' then 1 else 0 end) as moveis_cozinha_area_de_servico_jantar_e_jardim
        ,SUM(case when t4.product_category_name = 'alimentos_bebidas' then 1 else 0 end) as alimentos_bebidas
        ,SUM(case when t4.product_category_name = 'industria_comercio_e_negocios' then 1 else 0 end) as industria_comercio_e_negocios
        ,SUM(case when t4.product_category_name = 'livros_tecnicos' then 1 else 0 end) as livros_tecnicos
        ,SUM(case when t4.product_category_name = 'telefonia_fixa' then 1 else 0 end) as telefonia_fixa
        ,SUM(case when t4.product_category_name = 'fashion_calcados' then 1 else 0 end) as fashion_calcados
        ,SUM(case when t4.product_category_name = 'construcao_ferramentas_jardim' then 1 else 0 end) as construcao_ferramentas_jardim
        ,SUM(case when t4.product_category_name = 'eletrodomesticos_2' then 1 else 0 end) as eletrodomesticos_2
        ,SUM(case when t4.product_category_name = 'agro_industria_e_comercio' then 1 else 0 end) as agro_industria_e_comercio
        ,SUM(case when t4.product_category_name = 'artes' then 1 else 0 end) as artes
        ,SUM(case when t4.product_category_name = 'pcs' then 1 else 0 end) as pcs
        ,SUM(case when t4.product_category_name = 'sinalizacao_e_seguranca' then 1 else 0 end) as sinalizacao_e_seguranca
        ,SUM(case when t4.product_category_name = 'construcao_ferramentas_seguranca' then 1 else 0 end) as construcao_ferramentas_seguranca
        ,SUM(case when t4.product_category_name = 'artigos_de_natal' then 1 else 0 end) as artigos_de_natal
    FROM tb_orders AS T1 
        INNER JOIN tb_order_items AS T2 ON T1.order_id=T2.order_id
        LEFT JOIN ( SELECT T2.seller_id
                        ,MAX( julianday('2017-04-01') - julianday(t1.order_approved_at)) as idade_base
                    FROM tb_orders AS T1 
                        INNER JOIN tb_order_items AS T2
                            ON T1.order_id=T2.order_id
                    WHERE T1.order_approved_at BETWEEN '2016-10-01' AND '2017-04-01'
                        AND T1.order_status='delivered'
                    GROUP BY T2.seller_id) as T3 on t2.seller_id=t3.seller_id
        LEFT JOIN tb_products as t4 on t2.product_id=t4.product_id
        LEFT JOIN tb_order_reviews as t5 on t1.order_id=t2.order_id

    WHERE T1.order_approved_at BETWEEN '2016-10-01' AND '2017-04-01'
        AND T1.order_status='delivered'
    GROUP BY T2.seller_id) as t1 
LEFT JOIN tb_sellers as t2 on t1.seller_id=t2.seller_id 
order by t1.qtde_vendas desc
;


