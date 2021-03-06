#
# (C) Copyright IBM Corp. 2017
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#library (R4ML)

context("Testing r4ml.mlogit\n")

library("SparkR")
# test r4ml logistic regression

test_that("r4ml.mlogit", {
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_labelnames", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  labels = c("setosa", "versicolor", "virginica")
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, labelNames=labels)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_intercept", { 
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, intercept=T)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==5, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
  # As the coefficients are calculated in an n-dimensional bowl, we 
  # check a few of the extreme points to ensure we're at the minimum
  expect_equal(sort(coef(iris_log_reg)[,1])[4], 12.999295, tolerance=1e-2) 
  #expect_equal(coef(iris_log_reg)["Petal_Length", 2], -9.429609, tolerance=1e-2) 
  expect_equal(sort(coef(iris_log_reg)[,1])[5], 15.9683, tolerance=1e-2) 
})
  
test_that("r4ml.mlogit_shiftAndRescale", {  
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, shiftAndRescale=T, intercept=T)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==5, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_inner.iter", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, inner.iter.max=2)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_outer.iter", {
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, outer.iter.max=2)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_inner+outer", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, inner.iter.max=2, outer.iter.max=2)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_lambda2.5", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, lambda=2.5)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})
  
test_that("r4ml.mlogit_lambda0", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, lambda=0)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})

test_that("r4ml.mlogit_lambda500", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, lambda=500)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(abs(coef(iris_log_reg)[[1]][1]) - 1 <.001)
  expect_true(abs(coef(iris_log_reg)[[1]][1]) - 1 <.001)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})

test_that("r4ml.mlogit_tolerance", { 
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  ml.coltypes(iris_mat) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = iris_mat, tolerance=10)
  show(iris_log_reg)
  coef(iris_log_reg)
  #stopifnot(nrow(coef(iris_log_reg))==4, ncol(coef(iris_log_reg))==2)
  expect_true(nrow(coef(iris_log_reg))==5)
  expect_true(ncol(coef(iris_log_reg))==2)
})

test_that("scoring", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  s <- r4ml.sample(iris_mat, perc=c(0.2,0.8))
  test <- s[[1]]
  train <- s[[2]]
  ml.coltypes(train) <- c("scale", "scale", "scale", "scale", "nominal") 
  ml.coltypes(test) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = train, labelNames=c("Setosa","Versicolor","Virginica")) 
  output <- predict(iris_log_reg, test)
})
  
test_that("testing/prediction", {   
  df <- iris
  df$Species <- (as.numeric(df$Species))
  iris_df <- as.r4ml.frame(df, repartition = FALSE)
  iris_mat <- as.r4ml.matrix(iris_df)
  s <- r4ml.sample(iris_mat, perc=c(0.2,0.8))
  test <- s[[1]]
  train <- s[[2]]
  ml.coltypes(train) <- c("scale", "scale", "scale", "scale", "nominal") 
  ml.coltypes(test) <- c("scale", "scale", "scale", "scale", "nominal") 
  iris_log_reg <- r4ml.mlogit(Species ~ . , data = train, labelNames=c("Setosa","Versicolor","Virginica")) 
  test <- as.r4ml.matrix(test[, c(1:4)])
  output <- predict(iris_log_reg, test)
})

