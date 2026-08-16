select 
   raw_file as raw_json
,  filename as src_file_name
,  load_date as etl_load_timestamp
from 
  {{ source('cricket_rawdata', 'raw_data') }}