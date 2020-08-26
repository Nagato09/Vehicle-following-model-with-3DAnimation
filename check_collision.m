function collision=check_collision(obj,v1_pos,v2_pos)
if(v2_pos(1,1)-v1_pos(1,1)<obj.v1_length)
    collision=1;
else
    collision=0;
end