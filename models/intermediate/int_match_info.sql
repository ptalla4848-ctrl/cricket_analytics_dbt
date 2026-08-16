select raw_json:info.match_type::string as match_type
  ,raw_json:info.gender::string as gender
  ,raw_json:info.season::string as season
  ,raw_json:info.city::string as city
  ,raw_json:info.venue::string as venue
  ,raw_json:info.dates[0]::date as match_date
  ,raw_json:info.teams[0]::string  as team1
  ,raw_json:info.teams[1]::string  as team2
  ,raw_json:info.toss.winner::string as toss_winner
  ,raw_json:info.toss.decision::string as toss_decision
  ,raw_json:info.outcome.winner::string as match_winner
  ,case when raw_json:info.outcome.by.wickets::string is not null then raw_json:info.outcome.by.wickets::string||' wickets' 
    when raw_json:info.outcome.by.runs::string is not null then raw_json:info.outcome.by.runs::string||' runs' 
    else 'no result'
    end as margin
  ,raw_json:info.event.name::string as event_name
  ,raw_json:info.team_type::string as event_type
  ,raw_json:info.player_of_match[0]::string as pom
  ,src_file_name  
from {{ ref('stg_raw_cricket_data') }}