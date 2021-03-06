//===- tf_convert.td -----------------------------------------*- tblgen -*-===//
//
// Copyright (C) 2019-2020 Alibaba Group Holding Limited.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// =============================================================================

include "convert.td"

// Define TF extension inst
def TF_Broadcast : TFExtension<"Broadcast">;

def TF_Cast : TFExtension<"Cast"> {
  let extension_attr_ = [ExtensionAttr<"SrcT", EnumDataType, "INVALID">,
                         ExtensionAttr<"DstT", EnumDataType, "INVALID">,
                         ExtensionAttr<"Truncate", Bool, "false">];
}

def TF_ExpandDims : TFExtension<"ExpandDims">;

def TF_Fill : TFExtension<"Fill">;

def TF_Identity : TFExtension<"Identity">;

def TF_Reshape : TFExtension<"Reshape"> {
  let extension_attr_ = [ ExtensionAttr<"shape", IntegerList, "{}"> ];
}

def TF_Shape : TFExtension<"Shape">;

def TF_SquaredDifference : TFExtension<"SquaredDifference">;

def TF_Squeeze : TFExtension<"Squeeze"> {
  let extension_attr_ = [ ExtensionAttr<"squeeze_dims", IntegerList, "{}"> ];
}

def TF_StopGradient : TFExtension<"StopGradient">;

def TF_StridedSlice : TFExtension<"StridedSlice"> {
  let extension_attr_ = [ExtensionAttr<"begin_mask", Integer, "0">,
                         ExtensionAttr<"end_mask", Integer, "0">,
                         ExtensionAttr<"ellipsis_mask", Integer, "0">,
                         ExtensionAttr<"new_axis_mask", Integer, "0">,
                         ExtensionAttr<"shrink_axis_mask", Integer, "0">];
}

def TF_ResizeBilinear : OpMapping<"ResizeBilinear", Resize> {
  let attr_mapping_ = [
    AttributeMapping<"", "interpolation", "LINEAR">,
    AttributeMapping<"", "mode", "HALF_PIXEL_TF">,
    AttributeMapping<"", "axes_mask", "0x6"> // NHWC
    ];
}

def TF_FIFOQueueV2 : TFExtension<"FIFOQueueV2">;

def TF_QueueDequeueV2 : TFExtension<"QueueDequeueV2">;

def TF_SpaceToBatchND : TFExtension<"SpaceToBatchND">;

def TF_BatchToSpaceND : TFExtension<"BatchToSpaceND">;

// Define Halo instruction
def TF_Add : OpMapping<"Add", Add>;

def TF_ArgMax : OpMapping<"ArgMax", Argmax> {
 let attr_mapping_ = [
   AttributeMapping<"", "keep_dims", "false">];
}

def TF_AvgPool : OpMapping<"AvgPool", PoolingAvg> {
  let attr_mapping_ = [
    AttributeMapping<"strides", "strides", "{1,1,1,1}">,
    AttributeMapping<"ksize", "ksize", "{1,1,1,1}">,
    AttributeMapping<"padding", "padding", "VALID">,
    AttributeMapping<"data_format", "data_format", "NHWC">
  ];
}

def TF_BiasAdd : OpMapping<"BiasAdd", Add>;

def TF_BatchMatMul : OpMapping<"BatchMatMul", BatchMatMul> {
  let attr_mapping_ = [AttributeMapping<"adj_x", "transpose_a", "false">,
                       AttributeMapping<"adj_y", "transpose_b", "false">];
}

def TF_ConcatV2 : OpMapping<"ConcatV2", Concat> {
  let attr_mapping_ = [AttributeMapping<"N", "N", "0">];
}

def TF_Conv2D : OpMapping<"Conv2D", Conv2D> {
  let attr_mapping_ = [
    AttributeMapping<"padding", "padding", "VALID">,
    AttributeMapping<"strides", "strides", "{1,1,1,1}">,
    AttributeMapping<"data_format", "data_format", "NHWC">,
    AttributeMapping<"", "filter_format", "HWCN">,
    AttributeMapping<"dilations", "dilations", "{1,1,1,1}">,
    AttributeMapping<"", "group", "1">
  ];
}

def TF_DepthwiseConv2D : OpMapping<"DepthwiseConv2dNative", Conv2D> {
  let attr_mapping_ = [
    AttributeMapping<"padding", "padding", "VALID">,
    AttributeMapping<"strides", "strides", "{1,1,1,1}">,
    AttributeMapping<"data_format", "data_format", "NHWC">,
    AttributeMapping<"", "filter_format", "HWCN">,
    AttributeMapping<"dilations", "dilations", "{1,1,1,1}">,
    AttributeMapping<"", "group", "0">
  ];
}

def TF_EQ : OpMapping<"Equal", Cmp> {
  let attr_mapping_ = [AttributeMapping<"", "predicator", "EQ">];
}

def TF_Erf : OpMapping<"Erf", Erf>;

def TF_Floor : OpMapping<"Floor", Floor>;

def TF_Round: OpMapping<"Round", Round>;

def TF_FusedBatchNorm : OpMapping<"FusedBatchNorm", BatchNorm> {
  let attr_mapping_ = [
    AttributeMapping<"offset", "offset", "0">,
    AttributeMapping<"scale", "scale", "1">,
    AttributeMapping<"epsilon", "epsilon", "0.00001">,
    AttributeMapping<"data_format", "data_format", "NHWC">
  ];
}

def TF_GatherV2 : OpMapping<"GatherV2", Gather> {
  let attr_mapping_ = [AttributeMapping<"", "axis", "0">];
}

def TF_GreaterEqual : OpMapping<"GreaterEqual", Cmp> {
  let attr_mapping_ = [AttributeMapping<"", "predicator", "GE">];
}

def TF_Less : OpMapping<"Less", Cmp> {
  let attr_mapping_ = [AttributeMapping<"", "predicator", "LT">];
}

def TF_ListDiff : OpMapping<"ListDiff", SetDiff1D>;

def TF_MatMul: OpMapping<"MatMul", MatMul> {
  let attr_mapping_ = [
    AttributeMapping<"transpose_a", "transpose_a", "false">,
    AttributeMapping<"transpose_b", "transpose_b", "false">
  ];
}

def TF_Max : OpMapping<"Max", ReduceMax> {
  let attr_mapping_ = [
    AttributeMapping<"keep_dims", "keep_dims", "false">,
    AttributeMapping<"axis", "axis", "{}">];
}

def TF_MaxPool : OpMapping<"MaxPool", PoolingMax> {
  let attr_mapping_ = [
    AttributeMapping<"strides", "strides", "{1,1,1,1}">,
    AttributeMapping<"ksize", "ksize", "{1,1,1,1}">,
    AttributeMapping<"padding", "padding", "VALID">,
    AttributeMapping<"data_format", "data_format", "NHWC">
  ];
}

def TF_Mean : OpMapping<"Mean", ReduceMean> {
  let attr_mapping_ = [
    AttributeMapping<"keep_dims", "keep_dims", "false">,
    AttributeMapping<"axis", "axis", "{}">
  ];
}

def TF_Mul : OpMapping<"Mul", Mul>;

def TF_OneHot : OpMapping<"OneHot", OneHot> {
  let attr_mapping_ = [
    AttributeMapping<"axis", "axis", "-1">];
}

def TF_Pad : OpMapping<"Pad", Pad> {
  let attr_mapping_ =
      [AttributeMapping<"mode", "mode", "CONSTANT"> ];
}

def TF_Pack : OpMapping<"Pack", Stack> {
  let attr_mapping_ = [
    AttributeMapping<"axis", "axis", "0">];
}

def TF_Prod : OpMapping<"Prod", ReduceProduct> {
  let attr_mapping_ = [
    AttributeMapping<"keep_dims", "keep_dims", "false">,
    AttributeMapping<"axis", "axis", "{}">];
}

def TF_RealDiv : OpMapping<"RealDiv", Div>;

def TF_Relu : OpMapping<"Relu", Relu>;

def TF_Relu6 : OpMapping<"Relu6", Relu6>;

def TF_Rsqrt : OpMapping<"Rsqrt", Rsqrt>;

def TF_Slice : OpMapping<"Slice", Slice>;

def TF_Softmax : OpMapping<"Softmax", Softmax>;

def TF_Sqrt : OpMapping<"Sqrt", Sqrt>;

def TF_Sub : OpMapping<"Sub", Sub>;

def TF_Transpose : OpMapping<"Transpose", Transpose> {
  let attr_mapping_ = [
    AttributeMapping<"perm", "permutation", "{}">];
}

def TF_RandomUniform : OpMapping<"RandomUniform", RandomUniform> {
  let attr_mapping_ = [
    AttributeMapping<"seed", "seed", "0">,
    AttributeMapping<"dtype", "dtype", "FLOAT32">,
    AttributeMapping<"", "minval", "0.0">,
    AttributeMapping<"", "maxval", "1.0">];
}

def TF_Range : OpMapping<"Range", Range>;