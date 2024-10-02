class PaymentConstants {
  PaymentConstants._();

  static const merchantApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RRMk1UWTRMQ0p1WVcxbElqb2lNVGN3TkRBMU1ESXpNQzQzTlRVME16SWlmUS5MR0dGRkNQVnhqV3dOMU1IWlJobUw1S1RsXzAwTXpsM0JKQTR4MGdQb2N2TEtPeC1hYk9uOHpZYnBQcURYcU04WkQxOXZhcjBub2ZQV0dsN1MyMFR1dw==';
  static const paymentIntegerationId = '4414482';
  static const getAuthEndPoint = 'https://accept.paymob.com/api/auth/tokens';
  static const getOrderIdEndPoint =
      'https://accept.paymob.com/api/ecommerce/orders';
  static const getPaymentKeyEndPoint =
      'https://accept.paymob.com/api/acceptance/payment_keys';

  static String iFrame(String paymentToken) =>
      'https://accept.paymob.com/api/acceptance/iframes/808493?payment_token=$paymentToken'; // 808493 808492
}
