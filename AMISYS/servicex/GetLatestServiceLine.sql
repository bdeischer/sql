select substr(sx.serv_nbr,1,14) || max(substr(sx.serv_nbr,15,2))
from service_x sx
group by substr(sx.serv_nbr,1,14);

