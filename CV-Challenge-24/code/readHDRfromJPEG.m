function img = readHDRfromJPEG(jpegFilename)
% 读取图像（假设是32位深度的JPEG图像）
filename = 'your_32bit_image.jpg';
fid = fopen(filename, 'rb');
data = fread(fid, Inf, 'uint8');
fclose(fid);

% 处理图像数据，这里可以根据需要进行位深度的调整和处理

% 假设将32位深度降低到8位深度（示例）
min_val = min(data);
max_val = max(data);
scaled_data = uint8((double(data) - min_val) / (max_val - min_val) * 255);

% 保存为新的JPEG图像
new_filename = 'converted_image.jpg';
fid = fopen(new_filename, 'wb');
fwrite(fid, scaled_data, 'uint8');
fclose(fid);

% 显示转换后的图像
imshow(new_filename);
end
