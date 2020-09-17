function inRange_flag=check_inRange(v1_frame,v1_pos,ego_frame,ego_pos)
    [lf_radar mf_radar rf_radar] = get_radar_range(ego_frame,ego_pos);
    BoxA = lf_radar;
    BoxB = get_hitbox(v1_frame,v1_pos);
    CornersAx = transpose(BoxA(1,:));
    CornersAy = transpose(BoxA(2,:));
    CornersBx = transpose(BoxB(1,:));
    CornersBy = transpose(BoxB(2,:));
    
    in = inpolygon(CornersAx,CornersAy,CornersBx,CornersBy);
    
    if max(in) > 0
                inRange_flag = 3;
                return;
            else
                in = inpolygon(CornersBx,CornersBy,CornersAx,CornersAy);
                if max(in) > 0
                    inRange_flag = 3;
                    % To plot the collision scene
                    %plot(CornersAx,CornersAy,CornersBx,CornersBy)
                    return;               
                end
                
    end
    
    %check if in mf radar range
    BoxA = mf_radar;
    BoxB = get_hitbox(v1_frame,v1_pos);
    CornersAx = transpose(BoxA(1,:));
    CornersAy = transpose(BoxA(2,:));
    CornersBx = transpose(BoxB(1,:));
    CornersBy = transpose(BoxB(2,:));
    
    in = inpolygon(CornersAx,CornersAy,CornersBx,CornersBy);
    
    if max(in) > 0
                inRange_flag = 2;
                return;
            else
                in = inpolygon(CornersBx,CornersBy,CornersAx,CornersAy);
                if max(in) > 0
                    inRange_flag = 2;
                    % To plot the collision scene
                    %plot(CornersAx,CornersAy,CornersBx,CornersBy)
                    return;               
                end
                
    end
    
    %check if in rf radar range
     BoxA = rf_radar;
    BoxB = get_hitbox(v1_frame,v1_pos);
    CornersAx = transpose(BoxA(1,:));
    CornersAy = transpose(BoxA(2,:));
    CornersBx = transpose(BoxB(1,:));
    CornersBy = transpose(BoxB(2,:));
    
    in = inpolygon(CornersAx,CornersAy,CornersBx,CornersBy);
    
    if max(in) > 0
                inRange_flag = 1;
                return;
            else
                in = inpolygon(CornersBx,CornersBy,CornersAx,CornersAy);
                if max(in) > 0
                    inRange_flag = 1;
                    % To plot the collision scene
                    %plot(CornersAx,CornersAy,CornersBx,CornersBy)
                    return;    
                else
                    inRange_flag = 0;
                    return;  
                end
                
    end
end