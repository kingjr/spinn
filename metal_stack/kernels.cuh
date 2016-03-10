#ifndef _kernels_
#define _kernels_

#include <cstdlib>

#include <cuda_runtime.h>


namespace kernels {

  /**
   * Add two vectors inplace (writing to the first).
   *
   *     v1 = v1 * v1_coeff + v2 * v2_coeff
   */
  __global__ void addi_vv(float *v1, const float *v2,
          float v1_coeff, float v2_coeff);

  /**
   * Retrieve a subset of `N` rows from the contiguous `M * D` matrix `src`
   * and write them to `dst` (`M >= N`). `dst` should be large enough to hold
   * the `N * D` float result. `idxs` should be a length-`N` int array.
   *
   * In broadcasting Python code, this function is equivalent to the following:
   *
   *     idxs_ = idxs + idx_scal_shift
   *     idxs_ += idx_vec_shift_coeff * idx_vec_shift
   *     dst = src[idxs_]
   */
  __global__ void subtensor1(float *dst, const float *src, const int *idxs,
          int N, int D, int idx_scal_shift, int idx_vec_shift_coeff,
          int *idx_vec_shift)

  /**
   * Write an int scalar into a subtensor range.
   *
   *     dst[idxs + idx_scal_shift + idx_vec_shift_coeff * idx_vec_shift] = src
   */
  __global__ void set_subtensor1i_s(int *dst, int src, const int *idxs, int N,
          int idx_scal_shift, int idx_vec_shift_coeff, int *idx_vec_shift);

  /**
   * Switch over the rows of two matrices using a mask.
   *
   *     dst = T.switch(mask, ift, iff)
   *
   * where `ift`, `iff` are `N * D` matrices, and `mask` is an `N`-dimensional
   * vector.
   */
  __global__ void switch_m(float *dst, const int *mask, const float *ift,
          const float *iff, int N, int D);

}

#endif