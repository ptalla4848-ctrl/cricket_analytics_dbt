select
*
from {{ source('cricket_rawdata', 'players_info') }}