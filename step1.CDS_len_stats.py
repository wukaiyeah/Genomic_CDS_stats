import os
input = open('gencode.vM25.chr_patch_hapl_scaff.annotation.gff3','r')
output = open('mouse_CDS_len_stats.txt','w')
A=0
B=0
C=0
D=0
E=0
F=0
G=0
H=0
I=0
J=0
K=0
for line in input.readlines():
    if 'gene_type=protein_coding' in line:
        terms = line.strip().split('\t')
        if terms[2] == 'CDS':
            Len = abs(int(terms[4])-int(terms[3])) +1
            if 0 < Len and Len <= 100:
                A += 1
            elif 100 < Len and Len <= 200:
                B += 1
            elif 200 < Len and Len <= 300:
                C += 1
            elif 300 < Len and Len <= 400:
                D += 1
            elif 400 < Len and Len <= 500:
                E += 1
            elif 500 < Len and Len <= 600:
                F += 1
            elif 600 < Len and Len <= 700:
                G += 1
            elif 700 < Len and Len <= 800:
                H += 1
            elif 800 < Len and Len <= 900:
                I += 1
            elif 900 < Len and Len <= 1000:
                J += 1
            elif Len > 1000:
                K += 1
output.write('Range'+'\t'+'Num'+'\n')
output.write('0-100'+'\t'+str(A)+'\n')
output.write('101-200'+'\t'+str(B)+'\n')
output.write('201-300'+'\t'+str(C)+'\n')
output.write('301-400'+'\t'+str(D)+'\n')
output.write('401-500'+'\t'+str(E)+'\n')
output.write('501-600'+'\t'+str(F)+'\n')
output.write('601-700'+'\t'+str(G)+'\n')
output.write('701-800'+'\t'+str(H)+'\n')
output.write('801-900'+'\t'+str(I)+'\n')
output.write('901-1000'+'\t'+str(J)+'\n')
output.write('>1000'+'\t'+str(K))

input.close()
output.close()