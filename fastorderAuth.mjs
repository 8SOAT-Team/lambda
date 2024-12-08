const defaultPassword = 'Fast*Order'; 

export const handler = async (event) => {
  const cpf = event.headers['cpf'];
  const authorizationHeader = event.headers['Authorization'];

  let policyDocument;
  const principalId = 'user';

  if (!cpf) {
    policyDocument = generatePolicy(principalId, 'Allow', event.methodArn);
  } else {
    policyDocument = generatePolicy(principalId, 'Allow', event.methodArn);
  }

  if (authorizationHeader && authorizationHeader === `Basic ${Buffer.from(defaultPassword).toString('base64')}`) {
    policyDocument = generatePolicy(principalId, 'Allow', event.methodArn);
  } else {
    policyDocument = generatePolicy(principalId, 'Deny', event.methodArn);
  }

  return {
    principalId,
    policyDocument
  };
};

const generatePolicy = (principalId, effect, resource) => {
  return {
      Version: '2012-10-17',
      Statement: [
          {
              Action: 'execute-api:Invoke',
              Effect: effect,
              Resource: resource
          }
      ]
  };
};
