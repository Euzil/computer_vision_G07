function initGUI()
    % 初始化图形用户界面
    fig = figure('Name', '3D View Generator', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);

    % 添加图像选择按钮
    uicontrol('Style', 'pushbutton', 'String', '选择图像', 'Position', [10, 550, 100, 30], 'Callback', @selectImage);

    % 添加消失点和角点选择按钮
    uicontrol('Style', 'pushbutton', 'String', '选择消失点和角点', 'Position', [120, 550, 150, 30], 'Callback', @selectPoints);

    % 添加视角调整滑块
    uicontrol('Style', 'text', 'Position', [10, 500, 100, 20], 'String', '调整视角');
    uicontrol('Style', 'slider', 'Min', -180, 'Max', 180, 'Value', 0, 'Position', [120, 500, 200, 20], 'Callback', @adjustView);

    % harries检测
    uicontrol('Style', 'pushbutton', 'String', 'harries检测', 'Position', [280, 550, 150, 30], 'Callback', @harris);
    
    % 添加显示区域
    axes('Units', 'pixels', 'Position', [100, 50, 600, 400]);

    % 全局变量存储图像和点数据
    global img points vanishingPoint;
    img = [];
    points = [];
    vanishingPoint = [];

    function selectImage(~, ~)
        % 图像选择回调函数
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', '图像文件 (*.jpg, *.jpeg, *.png, *.bmp)'});
        if isequal(file, 0)
            disp('用户取消了图像选择');
        else
            img = imread(fullfile(path, file));
            imshow(img);
            title('选择的图像');
        end
    end
    

    function harris(~,~)
        gray = rgb_to_gray(img);
        harris_detector(gray, 'segment_length', 9, 'k', 0.06, 'do_plot', true);

    end

    function selectPoints(~, ~)
        % 消失点和角点选择回调函数
        if isempty(img)
            errordlg('请先选择图像', '错误');
            return;
        end
        imshow(img);
        title('选择消失点');
        [x, y] = ginput(1);
        vanishingPoint = [x, y];
        hold on;
        plot(x, y, 'r+', 'MarkerSize', 10, 'LineWidth', 2);
        title('选择四个角点');
        [x, y] = ginput(4);
        points = [x, y];
        plot(x, y, 'bo', 'MarkerSize', 10, 'LineWidth', 2);
        hold off;
    end

    function adjustView(hObj, ~)
        % 视角调整回调函数
        if isempty(img) || isempty(points) || isempty(vanishingPoint)
            errordlg('请先选择图像和消失点及角点', '错误');
            return;
        end
        angle = get(hObj, 'Value');
        disp(['视角调整为: ', num2str(angle)]);
        % TODO: 实现视角调整逻辑
        % 通过Homography矩阵生成新的视角
        % newView = generateNewView(img, points, vanishingPoint, angle);
        % imshow(newView);
    end
end
