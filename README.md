# computer_vision_G07

Computer Vision Challenge - SoSe 2024
Gruppe 07

Tour into the Picture

Goal: 
Create different views of a scene from a single image (rebuild 2-dimensions image into 3-dimensions).

Applicable version: 
Matlab 2020a Toolbox Installation: Image Processing Toolbox

Anweisungen zur Benutzung
Um die 3-dimensionale Rekonstruktion zu vervollständigen:
"Ein Bild auswählen": Wählen Sie ein Bild für die Rekonstruktion. Das Programm akzeptiert nur Dateien im ".jpg"- oder ".png"-Format.
"4 Eckpunkte udn 1 Fluchtpunkt definieren": Sie sollten einen Fluchtpunkt und vier Eckpunkte zum Einrahmen einer Ebene fur eine Homographie definieren. Sie können maximal 5 Punkte auswählen.
"Reset": Setzt alle von Ihnen gewählten Punkte und den Vordergrund zurück.
"START": Wenn Sie schon Bild auswählen und Punkte(4 Eckpunkte udn 1 Fluchtpunkt) richtig definieren, können Sie die Rekonstruktion starten.

Details:
Using the GUI the user can choose an image and then select the inner rectangle and the vanishing point. The program calculates the corners of the five planes and plots them on the original image. The algorithm uses these points to calculate an estimation of projective transformation for each plane based on the similar triangles method. The depth of the images is also estimated with this method. Then the planes are cropped and the transformation is made. As the last step, the planes are put together into a 3D box.



中文写吧
貌似可以当作Dokument的内容

Transform3D
首先定义Transform3D函数，这个函数是实现三维场景的渲染，在图形窗口中显示包含多个纹理的立体图形，即实现立体效果。
获取图片尺寸信息 -> 初始化坐标（三维）和角度 -> 创建坐标轴 Axes -> warp函数将目标图像和各个面的纹理图像放置在三维场景中，每个warp函数的参数确定了图像在三维空间中的位置和方向（5个：上下左右前） -> 设置坐标轴 -> 其余的是一些交互设置（调整视角和缩放，使用鼠标滚轮，更新坐标轴的显示范围和视角）
总结：这段代码创建了一个交互式的三维场景，其中可以通过鼠标滚轮来缩放场景，通过键盘来控制视角和位置，展示了如何将多个纹理图像放置在三维空间中以创建一个简单的立体效果。


ProjectiveRectification
根据控制点和非控制点（？）计算出3D图像的几何参数，如深度、高度和宽度 -> 使用控制点和非控制点定义了五个图像的矫正区域 -> fitgeotrans 函数根据定义的控制点和矫正区域进行投影变换的计算（trf_front = fitgeotrans()） -> imwarp 函数对每个图像进行投影变换，并结合 imrotate 和 fliplr 函数对图像进行旋转和翻转，以获得正确的矫正结果，每个图像都以 -90 度的角度旋转，并在需要时进行水平翻转，以确保投影矫正后的图像方向正确，并返回五个矫正后的图像（img_front_rectified = fliplr(imrotate(imwarp(img_front, trf_front, 'OutputView', imref2d([width,height])), -90));）
总结：这段代码实现了一个复杂的图像处理功能，主要包括计算投影变换矩阵、对多个图像进行投影矫正，并返回矫正后的图像及其几何参数。这种技术通常用于将多个图像（通常是从不同角度或位置获取的）投影到同一平面上，以便进行进一步的分析或合成。


ImageCropping
首先输入要剪裁的图像，彩色图像是三维数组，灰度是二维；polygon是一个二维数组，表示裁剪区域的多边形顶点坐标 -> 分别获取x,y坐标 -> roipoly 函数通过多边形的顶点坐标x,y生成二值掩码 BW，该掩码的尺寸与输入图像相同，其中裁剪区域内的像素值为 1，外部像素值为 0 -> 图像裁剪 -> 转换到uint8类型并输出
总结：这段代码通过将输入图像与指定的多边形区域掩码相乘的方式，实现了对图像的裁剪。裁剪过程中，仅保留多边形内的像素，并且将其它像素置为零，从而生成了一个裁剪后的图像。


CalculatePointCoordinates
首先输入图像以及控制点的坐标 -> 提取控制点(cpt_1 = control_pts(:, 1)) -> 计算非控制点坐标（上下左右各两个，一共8个） -> 输出八个非控制点的坐标
总结：这段代码的主要功能是根据输入图像和控制点的位置，计算出图像中八个用于几何操作的非控制点的坐标。这些点的计算依赖于图像的几何结构和控制点的位置关系，可以用于后续的图像变换、切片或其他几何处理。
