with stg_dp as (
   select * from  {{ ref('stg_default_powerplays') }}
),
stg_raw_data as (
   select * from {{ ref('stg_raw_cricket_data') }}
)


select 
 f0.index+1 as inning_id
,f.value:over::int+1 as over
,f0.value:team::string as batting_team 
,f1.index+1 as ball_in_over
,f1.value:batter::string as batter
,f1.value:bowler::string as bowler
,f1.value:non_striker::string as non_striker 
,f1.value:runs.batter::int as runs_batter
,OBJECT_keys(f1.value:extras)[0]::string as extra_type
,f1.value:runs.extras::int as runs_extras 
,f1.value:runs.total::int as runs_total
,f1.value:wickets[0].kind::string as dismissal_kind
,f1.value:wickets[0].player_out::string as out_player
,coalesce(ceil(f0.value:powerplays[0].from), sdp.start_over) as powerplays_start_over
,coalesce(ceil(f0.value:powerplays[0].to), sdp.end_over) as powerplays_end_over
, case when over between powerplays_start_over and powerplays_end_over then 1 else 0 end as is_powerplay
,src_file_name
from stg_raw_data
left join stg_dp sdp on raw_json:info.match_type::string = sdp.match_type
,lateral flatten(raw_json:innings) f0
,lateral flatten(f0.value:overs) f
,lateral flatten(f.value:deliveries) f1



