function [lf_radar_range,mf_radar_range,rf_radar_range] = get_radar_range(v_frame,v_pos)
    centerP = [v_pos(1);v_pos(2)];
    angle = v_pos(3); % Vehicle orientation in rad
    a = v_frame(1)/2;
    b = v_frame(2)/2;
    Rmatrix = [cos(angle) -sin(angle); sin(angle) cos(angle)];
    
    %get mid radar range, this is used for detecting obstacles in the same
    %lane
    p1 =[200+a; b+0.2];
    p2 =[200+a; -b-0.2];
    p3 =[a; -b];
    p4 =[a; b];
                        
    p1r = centerP+Rmatrix*p1;
    p2r = centerP+Rmatrix*p2;
    p3r = centerP+Rmatrix*p3;
    p4r = centerP+Rmatrix*p4;
            
    mf_radar_range = [p1r p2r p3r p4r];
    
    %get left radar range, this is used for detecting obstacles in the left
    %lane
    p1 =[200+a; -b-0.2];
    p2 =[200+a; -3*b-0.2];
    p3 =[a; -3*b];
    p4 =[a; -b];
                        
    p1r = centerP+Rmatrix*p1;
    p2r = centerP+Rmatrix*p2;
    p3r = centerP+Rmatrix*p3;
    p4r = centerP+Rmatrix*p4;
            
    lf_radar_range = [p1r p2r p3r p4r];
    
    %get right radar range, this is used for detecting obstacles in the
    %right
    %lane
    p1 =[200+a; 3*b+0.2];
    p2 =[200+a; b+0.2];
    p3 =[a; b];
    p4 =[a; 3*b];
                        
    p1r = centerP+Rmatrix*p1;
    p2r = centerP+Rmatrix*p2;
    p3r = centerP+Rmatrix*p3;
    p4r = centerP+Rmatrix*p4;
            
    rf_radar_range = [p1r p2r p3r p4r];
end