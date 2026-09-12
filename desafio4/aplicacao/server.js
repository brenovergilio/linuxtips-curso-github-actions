import express from 'express';
import giroPops from '@brenovergilio/giropops-strigus-girus';

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (_req, res) => {
  const nome = process.env.NOME_ALUNO || 'Tente Novamente';
  res.send(`${giroPops()} = ${nome}`);
});

app.listen(PORT, () => console.log(`Servidor em http://localhost:${PORT}`));