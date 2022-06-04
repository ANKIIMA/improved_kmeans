clear all;clc
%vegetablesÍ¼Ïñ²âÊÔ
figure
vegetables = imread('./picture/vegetables.png');
subplot(1,2,1);
imshow(vegetables);
title('vegetables');

[new_vegetables,vegetables_label,vegetables_s] = kmean_func(vegetables,8);
subplot(1,2,2);
imshow(new_vegetables);
title('segment_vegetables');
vegetables_s


%%houseÍ¼Ïñ²âÊÔ
figure
house = imread('./picture/house.png');
subplot(1,2,1);
imshow(house);
title('house');

[new_house,house_label,house_s] = kmean_func(house,4);
subplot(1,2,2);
imshow(new_house);
title('segment_house');
house_s

%%LenaÍ¼Ïñ²âÊÔ
figure
Lena = imread('./picture/Lena.png');
subplot(1,2,1);
imshow(Lena);
title('Lena');

[new_Lena,Lena_label,Lena_s] = kmean_func(Lena,17);
subplot(1,2,2);
imshow(new_Lena);
title('segment_Lena');
Lena_s

%planeÍ¼Ïñ²âÊÔ
figure
plane = imread('./picture/plane.png');
subplot(1,2,1);
imshow(plane);
title('plane');

[new_plane,plane_label,plane_s] = kmean_func(plane,20);
subplot(1,2,2);
imshow(new_plane);
title('segment_plane');
plane_s




