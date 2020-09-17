 function relative_distance = test(v1_pos,v2_pos,ego_pos)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
%             distance1 = sqrt((v1_pos(1,1)-ego_pos(1,1))^2+(v1_pos(2,1)-ego_pos(2,1))^2);
%             distance2 = sqrt((v2_pos(1,1)-ego_pos(1,1))^2+(v2_pos(2,1)-ego_pos(2,1))^2);
%             
%             if(distance1<250)
                if(check_inRange([4 2],v1_pos,[4 2],ego_pos))
                    distance1 = sqrt((v1_pos(1,1)-ego_pos(1,1))^2+(v1_pos(2,1)-ego_pos(2,1))^2);
                else
                    distance1 = 1000;
                end
                if(check_inRange([4 2],v2_pos,[4 2],ego_pos))
                    distance2 = sqrt((v2_pos(1,1)-ego_pos(1,1))^2+(v2_pos(2,1)-ego_pos(2,1))^2);
                else
                    distance2 = 1000;
                end
                
                relative_distance = min(distance1,distance2);
       end