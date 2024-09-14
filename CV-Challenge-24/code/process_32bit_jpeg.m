function process_32bit_jpeg(input_filename, output_filename)
    % 打开文件
    fid = fopen(input_filename, 'rb');
    if fid == -1
        error('无法打开文件 %s', input_filename);
    end

    try
        % 读取整个JPEG文件数据
        jpeg_data = fread(fid, Inf, 'uint8');
        fclose(fid);

        % 解析JPEG文件数据
        [img_data, width, height] = parseJPEG(jpeg_data);

        % 处理图像数据，将32位深度降低到8位深度（示例）
        img_data_8bit = uint8(img_data);

        % 保存为新的JPEG图像
        imwrite(img_data_8bit, output_filename);

        % 显示转换后的图像
        imshow(output_filename);

    catch ME
        % 异常处理
        if fid ~= -1
            fclose(fid);
        end
        rethrow(ME);
    end
end