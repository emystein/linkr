select tags.name as name, date(taggings.created_at) as created_at, count(1) as count
from taggings, tags
where taggings.tag_id = tags.id
group by date(taggings.created_at), name
order by count desc
