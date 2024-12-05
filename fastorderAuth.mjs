export const handler = async (event) => {
  let authStatus = 'Allow';

  const response = {
    policyDocument: { 
      Version: '2012-10-17',
      Statement: [
          {
              Action: 'execute-api:Invoke',
              Resource: [
                  event.methodArn
              ],
              Effect: authStatus
          }
      ]
    }
  };
  return response;
};
