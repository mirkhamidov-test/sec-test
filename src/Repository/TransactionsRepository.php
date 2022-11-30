<?php

declare(strict_types=1);

namespace App\Repository;

use App\Collection\FlagBitCollection;
use App\Enum\DatasetEnum;
use App\Exception\TransactionNotFoundException;

class TransactionsRepository extends AbstractNonEntityRepository
{
    public function findFlagBitsByTransId(int $transId): FlagBitCollection
    {
        $sql = <<<EOF
select
    tt.trans_id,
    md_fr.flagbit
FROM stamd_flagbit_ref md_fr
    RIGHT JOIN transaktion_transaktionen tt on md_fr.datensatz_id = tt.trans_id AND md_fr.datensatz_typ_id= :dataSetType
    INNER JOIN vorgaben_zeitraum vz ON (vz.zeitraum_id = md_fr.zeitraum_id)
WHERE tt.trans_id = :transactionId
AND NOW() BETWEEN vz.von AND vz.bis
EOF;
        $stmt = $this->getConnection()->prepare($sql);
        $resultSet = $stmt->executeQuery([
            'dataSetType' => DatasetEnum::TRANS_ID->value,
            'transactionId' => $transId,
        ]);

        if ($resultSet->rowCount() === 0) {
            throw new TransactionNotFoundException($transId);
        }

        $collection = new FlagBitCollection();

        foreach ($resultSet->iterateAssociative() as $value) {
            if (null === $value['flagbit']) {
                continue;
            }

            $collection->add((string) $value['flagbit']);
        }

        return $collection;
    }
}
