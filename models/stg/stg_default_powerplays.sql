select
  match_type,
  start_over,
  end_over
from {{ ref('default_powerplays') }}
