%Attempt for watermarking lena.
clc;close all;clear all;
l=imread('Watermarked_Lena(loc2).png');
o=l;
%imshow(l)
%title('Original Lena image');
%figure;
imshow(l)
title('Grayscale converted Lena');
figure;
imhist(l)
figure;
l=single(l);
imshow(edge(l))
title('Border of intensity changes')
figure;

for n=146:196
    for m=45:95
            l(n,m) = l(n,m) - l(n,m+1);
    end
end
l;
for n=1:50
    for m=1:50
            i(n,m) = l(n+145,m+45);
    end
end
i;

f=1;
z = -f;
for n=1:50
    for m=1:50
        if (i(n,m) > f )
            I(n,m) = i(n,m) - 1;
        elseif (i(n,m) < z)
            I(n,m) = i(n,m) + 1;
        else 
            I(n,m)=i(n,m);
        end
    end
end
I;

count=0;
for n=1:50
    for m=1:50
        if (I(n,m) == f)
            count = count + 1;
        elseif (I(n,m) == z)
            count = count + 1;
        else 
            count = count;
        end
    end
end
count
%{
b=imread('HelloBitmap.jpg');
imshow(b)
title('Original bitmap');
figure;
p=0;
for n=1:220
    for m=1:220
        d = b(n,m);     
        d=logical(dec2bin(d, 8) - '0');
        d= int8(d);
        %d = bitget(d,1);
        p = p + 1;
        h(p)= d(1,1);
        count = count - 1;
        if (count == 0)
            break;
        end
    end 
    if(count == 0)
        break;
    end
end
h;
%}

h = 'RIT is Good';
h = logical(dec2bin(h) - '0');

q = 1;
r = 1;
for n=1:50
    for m=1:50
        if( I(n,m) == f)
            if(q >= 12)
                a(n,m) = I(n,m);
            else
                if(h(q,r) == 1)
                    a(n,m) = I(n,m) - 1;
                    r = r + 1;
                else
                    a(n,m) = I(n,m);
                    r = r + 1;
                end
            end
        elseif( I(n,m) == z)
            if(q == 12)
                a(n,m) = I(n,m);
            else
                if(h(q,r) == 1)
                    a(n,m) = I(n,m) + 1;
                    r = r + 1;
                else
                    a(n,m) = I(n,m);
                    r = r + 1;
                end
            end
        else
            a(n,m) = I(n,m);
        end
        if( r == 8)
            q = q + 1;
            r = 1;
            
        end
    end
end
a;
A=zeros(220,220);
   for n=1:50
    for m=1:50
        A(n+145,m+45) = a(n,m);
    end
   end
A;
A = single(A);
A = uint8(A);
for n=1:220
    for m=1:220
        s(n,m) = o(n,m) + A(n,m);
    end
end
s;
imshow(s)
title('Decoded image')
%imwrite(s,'Decoded_Lena(loc2).png','png');
psnr(o,s)
%}