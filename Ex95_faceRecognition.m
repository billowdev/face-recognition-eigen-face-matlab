clear
a = imread('faceData/real_00000.jpg');
m = size(a);
row = m(1);
col = m(2);

% อ่านข้อมูลภาพใบหน้า 50 ภาพ

for ii=1:50
	if ii<11
		c00=sprintf('faceData/real_0000%d.jpg', ii-1);
	else
		c00=sprintf('faceData/real_000%d.jpg', ii-1);
	end
	a = imread(c00);
	aa=(a(:,:,1));

	f1=figure(1);
	M=10;
	N=5;

	% แสดงภาพใบหน้า 50 ภาพ
	c00=sprintf('subplot(%d,%d,%d)', M,N,ii);
    set(f1, 'Position', [10 10 650 950])
	eval(c00);
	imagesc(a);
	colormap(gray)
	axis off

	% ลบค่าเฉลี่ย
	aaa=im2double(aa);
	b=matrix2rowvector(aaa);
	mn(ii) = mean(b);
	fdata(ii,:) = b - mn(ii);

end

% คำนวณไอแกนเวคเตอร์
% c = fdata*fdata';
c = fdata*fdata';
[v,d] = eig(c); 
[v,d] = swap_matrix(v,d);

% คำนวณไอแกนเฟส
efdata = v'*fdata;

% แสดงไอแกนเฟส

for ii=1:50
    e=efdata(ii,:);
    f = rowvector2matrix(e,row,col);
    if ii<11
        c00=sprintf('ef%d=f;', ii-1);
        eval(c00);
    else
        c00=sprintf('ef%d=f;', ii-1);
    end
end

figure(2)
M=10;
N=5;
count=0;
for i=1:M
    for j=1:N
        count=count+1;
        c00=sprintf('subplot(%d, %d, %d)', M, N, count);
        eval(c00);
        if count<11
            % c00=sprintf('imagesc(ef0%d);', count-1);
            c00=sprintf('imagesc(ef0%d);', count-1);
            eval(c00);
            colormap(gray);
            axis off
        else
            c00=sprintf('imagesc(ef%d)', count-1);
            eval(c00);
            colormap(gray)
            axis off
        end
    end
end

% คำนวณสัมประะสิทธ์โดยการโปรเจคชันข้อมูลใบหน้าลงบนไอแกนเฟส
omeca=efdata*fdata';

%สร้างภาพคืน

rcdata=omeca*efdata;

% แสดงภาพที่สร้างคืน
for ii=1:50
    e=rcdata(ii,:);
    f=rowvector2matrix(e,row,col)+mn(ii);
    if ii<11
        c00=sprinf('rf0%d=f;', ii-1);
        eval(c00);
    else
        c00=sprinf('rf%d=f;',ii-1);
        eval(c00);
    end
end
figure(3);
M=10;
N=5;
count=0;
for i=1:M
    for j=1:N
        count=count+1;
        c00=sprinf('subplot(%d,%d,%d',M,N,count);
        eval(c00);
        if count<11
            c00=sprintf('imagesc(rf0%d)', count-1);
            eval(c00);
            colormap(graay)
            axis off
        else
            c00=sprinf('imagesc(rf%d', count-1);
            eval(c00);
            colormap(gray)
            axis off
        end
    end
end

% ระบุใบหน้าที่ไม่รู้จัก
a = imread('unknow3.jpg');
a = a(:,:,1);
a = im2double(a);
aa = matrix2rowvector(a);
pr=efdata*aa';
for ii=1:50
    er(ii) = sum(abs(omeca(:,ii)-pr));
end
[Y, I] = min(er)
figure(4), subplot(2,1,1)
imagesc(a);
colormap(gray)

axis off
title('Anonumous');
if I<11
    c00=sprinf('face0000%d.jpg', I-1);
else
    c00=sprinf('face000%d.jpg', I-1);
end
a = imread(c00);
aa = a(:,:,1);
figure(4), subplot(2,1,2)
imagesc(a);
colormap(gray)
title('Person Indentified');
axis off
