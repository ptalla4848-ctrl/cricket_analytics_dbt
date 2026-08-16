select  f1.value::string as player_name,f0.key as team_name
from {{ ref('stg_raw_cricket_data') }}
, lateral flatten(raw_json:info.players) f0
, lateral flatten(f0.value) as f1
group by all