// Generated by RcppR6 (0.2.3): do not edit by hand
#include <glmmsr.h>

// [[Rcpp::export]]
std::vector<MixedContinuousBelief> continuous_beliefs__ctor() {
  return std::vector<MixedContinuousBelief>();
}
// [[Rcpp::export]]
void continuous_beliefs__append_glmm_belief(glmmsr::RcppR6::RcppR6<std::vector<MixedContinuousBelief> > obj_, std::vector<int> items, Eigen::MatrixXd X, Eigen::MatrixXd Zt, Eigen::SparseMatrix<double> Lambdat, Eigen::VectorXi Lind, Eigen::ArrayXd response, Eigen::ArrayXd weights) {
  appendGLMMBelief(*obj_, items, X, Zt, Lambdat, Lind, response, weights);
}
// [[Rcpp::export]]
void continuous_beliefs__append_normal_belief(glmmsr::RcppR6::RcppR6<std::vector<MixedContinuousBelief> > obj_, std::vector<int> items, Eigen::VectorXd mean, Eigen::MatrixXd precision) {
  appendNormalBelief(*obj_, items, mean, precision);
}
// [[Rcpp::export]]
int continuous_beliefs__size(glmmsr::RcppR6::RcppR6<std::vector<MixedContinuousBelief> > obj_) {
  return obj_->size();
}

// [[Rcpp::export]]
Parameters calibration_parameters__ctor() {
  return makeParametersR();
}
// [[Rcpp::export]]
Eigen::VectorXd calibration_parameters__theta__get(glmmsr::RcppR6::RcppR6<Parameters> obj_) {
  return obj_->GLMMTheta;
}
// [[Rcpp::export]]
void calibration_parameters__theta__set(glmmsr::RcppR6::RcppR6<Parameters> obj_, Eigen::VectorXd value) {
  obj_->GLMMTheta = value;
}

// [[Rcpp::export]]
Eigen::VectorXd calibration_parameters__beta__get(glmmsr::RcppR6::RcppR6<Parameters> obj_) {
  return obj_->GLMMBeta;
}
// [[Rcpp::export]]
void calibration_parameters__beta__set(glmmsr::RcppR6::RcppR6<Parameters> obj_, Eigen::VectorXd value) {
  obj_->GLMMBeta = value;
}

// [[Rcpp::export]]
std::string calibration_parameters__family__get(glmmsr::RcppR6::RcppR6<Parameters> obj_) {
  return getParametersFamily(*obj_);
}
// [[Rcpp::export]]
void calibration_parameters__family__set(glmmsr::RcppR6::RcppR6<Parameters> obj_, std::string value) {
  setParametersFamily(*obj_, value);
}

// [[Rcpp::export]]
std::string calibration_parameters__link__get(glmmsr::RcppR6::RcppR6<Parameters> obj_) {
  return getParametersLink(*obj_);
}
// [[Rcpp::export]]
void calibration_parameters__link__set(glmmsr::RcppR6::RcppR6<Parameters> obj_, std::string value) {
  setParametersLink(*obj_, value);
}

// [[Rcpp::export]]
int calibration_parameters__n_sparse_levels__get(glmmsr::RcppR6::RcppR6<Parameters> obj_) {
  return getParametersNSparseLevels(*obj_);
}
// [[Rcpp::export]]
void calibration_parameters__n_sparse_levels__set(glmmsr::RcppR6::RcppR6<Parameters> obj_, int value) {
  setParametersNSparseLevels(*obj_, value);
}

// [[Rcpp::export]]
int calibration_parameters__n_quadrature_points__get(glmmsr::RcppR6::RcppR6<Parameters> obj_) {
  return getParametersNQuadraturePoints(*obj_);
}
// [[Rcpp::export]]
void calibration_parameters__n_quadrature_points__set(glmmsr::RcppR6::RcppR6<Parameters> obj_, int value) {
  setParametersNQuadraturePoints(*obj_, value);
}


// [[Rcpp::export]]
ClusterGraph cluster_graph__ctor(std::vector<MixedContinuousBelief> beliefs) {
  return ClusterGraph(beliefs);
}
// [[Rcpp::export]]
double cluster_graph__compute_log_normalizing_constant(glmmsr::RcppR6::RcppR6<ClusterGraph> obj_, Eigen::VectorXd mean, Eigen::SparseMatrix<double> precision, Parameters parameters) {
  return computeLogNormalizingConstant(*obj_, mean, precision, parameters);
}
// [[Rcpp::export]]
int cluster_graph__width__get(glmmsr::RcppR6::RcppR6<ClusterGraph> obj_) {
  return obj_->width();
}
