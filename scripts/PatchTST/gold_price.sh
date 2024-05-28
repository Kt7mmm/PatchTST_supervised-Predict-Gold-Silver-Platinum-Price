#!/bin/bash

# Kiểm tra và tạo thư mục logs nếu chưa tồn tại
mkdir -p ./logs/LongForecasting

# Thiết lập các biến cần thiết
seq_len=104
model_name=PatchTST
root_path_name=./dataset/
data_path_name=gold_price.csv
model_id_name=gold_price
data_name=custom
random_seed=2021

# Vòng lặp cho các giá trị pred_len khác nhau
for pred_len in 24 36 48 60
do
    python -u run_longExp.py \
      --random_seed $random_seed \
      --is_training 1 \
      --root_path $root_path_name \
      --data_path $data_path_name \
      --model_id ${model_id_name}_${seq_len}_${pred_len} \
      --model $model_name \
      --data $data_name \
      --features M \
      --seq_len $seq_len \
      --pred_len $pred_len \
      --enc_in 1 \
      --e_layers 3 \
      --n_heads 4 \
      --d_model 16 \
      --d_ff 128 \
      --dropout 0.3 \
      --fc_dropout 0.3 \
      --head_dropout 0 \
      --patch_len 24 \
      --stride 2 \
      --des 'Exp' \
      --train_epochs 5 \
      --batch_size 16 \
      --learning_rate 0.0025 \
      --itr 1 > logs/LongForecasting/${model_name}_${model_id_name}_${seq_len}_${pred_len}.log
done
