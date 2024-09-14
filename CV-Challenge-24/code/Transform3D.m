function Transform3D(x,y,img_target,img_front, img_left, img_right, img_top, img_bottom)
% Creates a 3D scene, placing a target image and six face images (front, left, right, top, bottom) onto respective 3D planes.
%  x, y: Coordinates for placing the target image.
%  img_target: Target image.
%  img_front: Front face image.
%  img_left: Left face image.
%  img_right: Right face image.
%  img_top: Top face image.
%  img_bottom: Bottom face image.

% Initialization
% Creates a figure window with a white background and Gets the dimensions of each image
hold off
f = figure('Color','w');
    [height, width, ~] = size(img_front);
    [height2, width2, ~] = size(img_bottom);
    [height3, width3, ~] = size(img_left);
    [height_t, width_t, ~] = size(img_target);

    % scale_factor = 1; 
    % 
    % height = height * scale_factor;
    % width = width * scale_factor;
    % height2 = height2 * scale_factor;
    % width2 = width2 * scale_factor;
    % height3 = height3 * scale_factor;
    % width3 = width3 * scale_factor;
    % height_t = height_t * scale_factor;
    % width_t = width_t * scale_factor;

% Image Placement and Initial Angle
  % pos defines the initial position.
  % angle defines the initial view angle.
    pos = [0,0,0];
    angle = [10,20];
% Sets the mouse scroll wheel event callback to ScrollWheel.
  % Axes creates an axis for plotting.
  % range defines the initial display range.
    set (gcf, 'WindowScrollWheelFcn', @ScrollWheel);
    Axes =axes (gcf,'Position',[0.1, 0.1,0.8,0.8]);
    range = 1000;
    
    target_x = x-width2/2-0.5*width_t; %Determine the x-coordinate of the target 
    target_y = y; %Determine the y-coordinate of the target
   
% Target Image Placement in the 3D Scene
 %  Uses meshgrid to generate the grid coordinates for the target image
 %  Uses warp to place the target image into the 3D scene.
    [X, Z] = meshgrid(-(width_t-1)/2 +target_x: (width_t-1)/2+target_x, (height_t-1)-(height3-1)/2: -1 : -(height3-1)/2);
    Y = ones(height_t,width_t)* target_y;
    warp(X, Y, Z, img_target); hold on      

% Placing Other Face Images in the 3D Scene    
  % The right side put into the 3D scene
    [Y, Z] = meshgrid(0 : width3-1, (height3-1)/2 : -1 : -(height3-1)/2);
    X = ones(height3, width3) * width / 2;
    f1 = warp(X, Y, Z, img_right); 
    hold on

  % The left side put into the 3D scene
    [Y, Z] = meshgrid(width3-1 : -1 : 0, (height3-1)/2  : -1 :-(height3-1)/2 );
    X = - ones(height3, width3) * width / 2;
    f2 = warp(X, Y, Z, img_left); 
    hold on

  % The bottom side put into the 3D scene
    [X, Y] = meshgrid(-(width2-1)/2 : (width2-1)/2, 0 : (height2-1));
    Z = -ones(height2, width2) * height / 2;
    f3 = warp(X, Y, Z, img_bottom); 
    hold on

  % The top side put into the 3D scene
    [X, Y] = meshgrid(-(width2-1)/2 : (width2-1)/2, 0: (height2-1) );
    Z = ones(height2, width2)* height/2;
    f4 = warp(X, Y, Z, img_top); 
    hold on

  % The front side put into the 3D scene
    [X, Z] = meshgrid(-(width-1)/2 : (width-1)/2,  (height-1)/2 : -1 : -(height-1)/2);
    Y = zeros(height, width);
    f5 = warp(X, Y, Z, img_front); 
    hold off

% Axis and Grid Settings
    axis(Axes,'equal')
    grid(Axes,'on')
    xlabel('x');
    ylabel('y');
    zlabel('z');
    update(Axes,pos)

    ax = gca;              
    ax.Clipping = 'off'; 
    % axis off
    cameratoolbar(f);


% Mouse Scroll Wheel Event
% Handles the mouse scroll wheel event to zoom in and out of the view.
    function ScrollWheel(~, event)
        value = event.VerticalScrollCount*10;
        range = max(1,range+value);
        update()
    end

% Update View
% Updates the view based on the current position and range, setting the axis limits and view angle.
    function update(~,~)
        axis(Axes,[-range+pos(1) , range+pos(1), -range+pos(2) , range+pos(2), -range+pos(3) , range+pos(3)])
        view(Axes, angle)
        drawnow
    end
end

