function [A_new,label,s1] = kmean_improve(A,K)
A = double(A);
Ar = A(:,:,1);
Ag = A(:,:,2);
Ab = A(:,:,3);


[m,n] = size(Ar);
Af = zeros(m,n);
Alast = zeros(m,n);
bk = zeros(m,n);

r = zeros(1,K);
g = zeros(1,K);
b = zeros(1,K);
%开始计实

tic
for i=1:K
    r(i) = A(randi([1,m],1),randi([1,n],1),1);
    g(i) = A(randi([1,m],1),randi([1,n],1),2);
    b(i) = A(randi([1,m],1),randi([1,n],1),3);
end
label = zeros(m,n);

for k = 1:100
    for i = 1:m
        for j = 1:n
            if Af(i,j) > 0
                Af(i,j) = Af(i,j) - 1;
                continue;
            end
            temp_value = 0;
            for dis = 1:K
                value = (Ar(i,j)-r(dis))^2 + (Ag(i,j)-g(dis))^2 + (Ab(i,j)-b(dis))^2;
                if temp_value == 0 || temp_value>value
                    Alast(m,n) = temp_value;
                    temp_value = value;
                    label(i,j) = dis;
                end
            end
            if temp_value < 0.1 * Alast(m,n)
                Af(i,j) = 3;
            end
        end
    end
    
    for i = 1:K
        r(i) = mean(Ar(label == i));
        g(i) = mean(Ag(label == i));
        b(i) = mean(Ab(label == i));
    end

end
toc


A_new = zeros(m,n,3);
s = zeros(m,n);
for i = 1:m
    for j = 1:n
        A_new(i,j,1) = r(label(i,j));
        A_new(i,j,2) = g(label(i,j));
        A_new(i,j,3) = b(label(i,j));
        %簇内不相似度
        tempR = (Ar(i,j) - Ar(label == label(i,j))).^2;
        tempG = (Ag(i,j) - Ag(label == label(i,j))).^2;
        tempB = (Ab(i,j) - Ab(label == label(i,j))).^2;
        a = sqrt(tempR + tempG + tempB);
        a(a==0) = [];
        a = mean(a);
        %簇间相似度
        b_cluster = 0;
        for dim = 1:K
            d_k = sqrt((Ar(i,j) - A_new(i,j,1)).^2 + (Ag(i,j) - A_new(i,j,1)).^2 + (Ab(i,j) - A_new(i,j,1)).^2);
            if b_cluster == 0 || b_cluster > d_k
                b_cluster = d_k;
            end
        end
        
        s(i,j) = (b_cluster - a) / max(b_cluster, a);
        
    end
end

s1 = mean(mean(s));
A_new = uint8(A_new);
end
